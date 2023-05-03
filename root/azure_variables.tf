variable "display_name" {
  description = "display name of app registration"
  type        = string
  default     = "suhail-app-final"
}

variable "redirect_uris" {
  description = "redirection urls of application"
  type        = list(string)
  default     = ["https://app.example.net/account"]
}

variable "access_token_issuance_enabled" {
  description = "controls whether to enable issuance of access tokens"
  type        = bool
  default     = true
}

variable "id_token_issuance_enabled" {
  description = "controls whether to enable issuance of id tokens"
  type        = bool
  default     = true
}

variable "tenant_id" {
  default     = "9b7cbd77-6d6b-4879-8aba-63d7dfb18472"
  description = "tenant id of azure active directory"
  type        = string
}
