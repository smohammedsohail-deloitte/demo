provider "azurerm" {
  features {}
  skip_provider_registration = true
}

data "azuread_client_config" "current" {}

resource "azuread_application" "example" {
  display_name = var.display_name
  owners       = [data.azuread_client_config.current.object_id]
  web {
    redirect_uris = ["https://${var.domain}.auth.us-east-1.amazoncognito.com/oauth2/idpresponse"]

    implicit_grant {
      access_token_issuance_enabled = var.access_token_issuance_enabled
      id_token_issuance_enabled     = var.id_token_issuance_enabled
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph API

    # Required OpenID permissions for Microsoft Graph API
    # See https://docs.microsoft.com/en-us/graph/permissions-reference#openid-permissions
    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e" # openid
      type = "Scope"
    }
    resource_access {
      id   = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0" # email
      type = "Scope"
    }

    # Required Profile permissions for Microsoft Graph API
    # See https://docs.microsoft.com/en-us/graph/permissions-reference#profile-permissions
    resource_access {
      id   = "14dad69e-099b-42c9-810b-d002981feec1" # profile
      type = "Scope"
    }

    # Add other required permissions here...
  }
}

resource "azuread_application_password" "example" {
  application_object_id = azuread_application.example.object_id
}

module "cognito" {

  source = "../modules"

  user_pool_name = "digiprintpool"
  domain         = "digiprint"

  clients = [
    {
      allowed_oauth_flows                  = ["code", "implicit"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["email", "openid", "profile"]
      callback_urls                        = ["https://czjmt7gta7.execute-api.us-east-1.amazonaws.com/dev/example"]
      default_redirect_uri                 = "https://czjmt7gta7.execute-api.us-east-1.amazonaws.com/dev/example"
      explicit_auth_flows                  = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
      generate_secret                      = false
      logout_urls                          = []
      name                                 = "digiprintapp"
      read_attributes                      = ["email"]
      supported_identity_providers         = ["AzureAD", "COGNITO"]
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 1
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
  }]

  identity_providers = [
    {
      provider_name = "AzureAD"
      provider_type = "OIDC"

      provider_details = {
        oidc_issuer               = "https://login.microsoftonline.com/${var.tenant_id}/v2.0"
        client_id                 = azuread_application.example.application_id
        client_secret             = azuread_application_password.example.value
        authorize_scopes          = "email openid profile"
        attributes_request_method = "GET"
      }

      attribute_mapping = {
        email    = "email"
        username = "sub"
      }
    }
  ]





}
