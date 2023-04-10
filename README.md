
# Monitoring and Logging

## Introduction
Monitoring involves the process of continuously tracking and observing the performance and behavior of your application, infrastructure, and services. It is used to detect and diagnose issues, performance bottlenecks, and errors in real-time or near-real-time. Monitoring helps you maintain the uptime and availability of your applications and ensures that they are performing optimally. You can use monitoring tools to collect metrics, such as CPU usage, memory utilization, network throughput, and response time, and set alerts when these metrics exceed certain thresholds.

Logging involves the process of capturing and storing the events and actions that occur within your application and infrastructure. This includes error messages, warnings, status updates, and other relevant information. Logging helps you understand what happened when an issue occurred, diagnose the root cause of problems, and troubleshoot issues more effectively. You can use logging tools to collect and aggregate log data from different sources, such as servers, containers, and applications, and analyze this data to gain insights and improve your application's performance.

Both monitoring and logging are critical for maintaining the health and performance of your applications, and they work together to help you detect, diagnose, and resolve issues. By monitoring your application's performance and collecting logs, you can gain visibility into your application's behavior, troubleshoot issues, and optimize its performance.

## RoadMap

- AWS Monitoring and Logging Service
- Use Cases
- ECS Monitoring and Logging
- EKS Monitoring and Logging Using FluentBit
- Best Practices for Monitoring and Logging

## AWS Monitoring and Logging Services

Amazon Web Services (AWS) provides several services for monitoring and logging, which are crucial for maintaining the health and performance of your applications running on AWS. Here are some of the AWS services that can help with monitoring and logging:

- Amazon CloudWatch: It is a monitoring service for AWS resources and the applications run on AWS. CloudWatch can collect and track metrics, collect and monitor log files, and set alarms. Use CloudWatch to gain system-wide visibility into resource utilization, application performance, and operational health.

- AWS CloudTrail: It is a service that enables governance, compliance, operational auditing, and risk auditing of AWS account. With CloudTrail, one can log, continuously monitor, and retain account activity related to actions across your AWS infrastructure.

- AWS X-Ray: It is a service that helps analyze and debug production, distributed applications, such as those built using a microservices architecture. X-Ray provides an end-to-end view of requests as they travel through application, and shows a map of  application's underlying components.

- Amazon Elasticsearch Service: It is a managed service that makes it easy to deploy, operate, and scale Elasticsearch clusters in the AWS Cloud. Elasticsearch is a popular open-source search and analytics engine that you can use to store, search, and analyze your data.

- Amazon Managed Service for Prometheus: It is a fully managed service that makes it easy to monitor containerized applications at scale. With Managed Service for Prometheus, one can collect and query metrics from containerized applications, AWS services, and on-premises resources.

## Use Cases 

- Application Performance Monitoring (APM): Suppose a web application running on AWS, and want to monitor its performance and identify any issues that may be affecting its response time or throughput. Use AWS CloudWatch to collect metrics such as CPU usage, network traffic, and database connections, and set alarms to alert  when these metrics exceed certain thresholds. Additionally, use AWS X-Ray to trace requests as they travel through your application and identify bottlenecks or errors.

- Security Monitoring: Suppose, to monitor your AWS account for unauthorized access attempts, changes to security groups or access policies, or other security-related events.Use AWS CloudTrail to log all API calls made to your AWS account and analyze this data to detect potential security threats. Also use AWS GuardDuty to monitor your AWS resources for threats such as malware, phishing, and unauthorized access.

- Container Monitoring: Suppose, running a containerized application on AWS and want to monitor its performance, resource utilization, and logs. Use Amazon Managed Service for Prometheus to collect and query metrics from your containers, AWS services, and on-premises resources. Also use Amazon Elasticsearch Service to store and analyze logs from your containers and infrastructure.

- Infrastructure Monitoring: Suppose, to monitor the health and performance of AWS infrastructure, such as EC2 instances, RDS databases, and load balancers. Use AWS CloudWatch to collect metrics and logs from these resources and set alarms to notify you of any issues. Also use AWS Systems Manager to automate common maintenance and deployment tasks, such as patch management and configuration updates.

- DevOps Monitoring: Suppose, a continuous integration and deployment (CI/CD) pipeline running on AWS, and you want to monitor the performance and health of your pipeline. Use AWS CodePipeline to automate your software release process and monitor its progress in real-time. Also use AWS CloudWatch to collect metrics, such as build times, test results, and deployment frequency, and set alarms to notify you of any issues.

- Serverless Application Monitoring: Suppose, a serverless application running on AWS Lambda, and want to monitor its performance, errors, and logs. Use AWS X-Ray to trace requests as they flow through your application and identify any issues or bottlenecks. Also use AWS CloudWatch to collect and analyze Lambda function metrics, such as invocation rates, duration, and errors, and set alarms to notify you of any issues.

## ECS Monitoring and Logging

Amazon Elastic Container Service (ECS) is a highly scalable container management service that makes it easy to run, stop, and manage Docker containers on a cluster. Logging and monitoring are essential for maintaining the health and performance of your ECS clusters and the applications running on them.

In this example, we'll explore how to configure logging and monitoring for an ECS cluster using the following services:

- Amazon CloudWatch Logs: for collecting, monitoring, and storing container logs.
- Amazon CloudWatch Metrics: for collecting, monitoring, and storing container metrics.
- AWS CloudFormation: for automating the provisioning of resources.
- AWS X-Ray: for distributed tracing and request analysis.

Step-1: Create an ECS cluster

To get started, create an ECS cluster with Fargate launch type using AWS CloudFormation. Here's an example CloudFormation template

    Resources:
    ECSCluster:
        Type: AWS::ECS::Cluster
        Properties:
        ClusterName: my-ecs-cluster

Step-2: Configure logging

Next, configure your containers to send logs to Amazon CloudWatch Logs. You can do this by setting the log-driver option in your task definition to awslogs and providing the log group and log stream names. Here's an example task definition

    {
    "family": "my-task",
    "containerDefinitions": [
        {
        "name": "my-container",
        "image": "my-image",
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
            "awslogs-group": "/ecs/my-task",
            "awslogs-region": "us-east-1",
            "awslogs-stream-prefix": "my-container"
            }
        }
        }
    ]
    }

This configuration sends logs from the my-container container to the /ecs/my-task log group in the us-east-1 region with a log stream prefix of my-container.

Step-3: Configure X-Ray tracing

To enable X-Ray tracing, you need to modify the task definition for your container to include the X-Ray daemon as a sidecar container. Here's an example task definition

    {
    "family": "my-task",
    "containerDefinitions": [
        {
        "name": "my-container",
        "image": "my-image",
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
            "awslogs-group": "/ecs/my-task",
            "awslogs-region": "us-east-1",
            "awslogs-stream-prefix": "my-container"
            }
        }
        },
        {
        "name": "xray-daemon",
        "image": "amazon/aws-xray-daemon",
        "essential": true,
        "portMappings": [
            {
            "containerPort": 2000,
            "hostPort": 2000,
            "protocol": "udp"
            }
        ],
        "environment": [
            {
            "name": "AWS_REGION",
            "value": "us-east-1"
            }
        ]
        }
    ]
    }

This configuration includes an X-Ray daemon container that runs alongside the my-container container. The daemon listens for UDP traffic on port 2000 and sends trace data to the X-Ray service.

Step-4: Create CloudWatch Metrics alarms

You can create CloudWatch Metrics alarms to monitor your ECS cluster and containers. Alarms can be set up to notify you via email or SMS when a metric exceeds a threshold. Here's an example CloudFormation template for creating a CPU usage alarm

    Resources:
    CPUAlarm:
        Type: AWS::CloudWatch::Alarm
        Properties:
        AlarmName: ecs-cpu-alarm
        AlarmDescription: CPU utilization of ECS service
        MetricName: CPUUtilization
        Namespace: AWS/ECS
        Statistic: Average
        Period: '60'
        EvaluationPeriods: '5'
        Threshold: '80'
        ComparisonOperator: GreaterThanThreshold
        Dimensions:
            - Name: ServiceName
            Value: my-service

This configuration creates an alarm that monitors the CPUUtilization metric for the my-service service in the AWS/ECS namespace. If the metric exceeds 80% for five consecutive periods of 60 seconds, the alarm triggers.

Step-5: View logs and metrics

Once you've configured logging and monitoring, you can view logs and metrics in the Amazon CloudWatch console. Logs are stored in log groups, and you can search and filter logs using the console or the CloudWatch Logs Insights feature. Metrics are displayed in graphs and can be customized to display specific metrics and time periods.

## EKS Monitoring and Logging Using FluentBit

Here's a brief overview of the tools and concepts we'll be working with:

- Amazon EKS is a managed Kubernetes service that makes it easy to run Kubernetes clusters on AWS.
- Fluent Bit is an open-source and lightweight log processor and forwarder that is capable of collecting, parsing, and forwarding log data.
- Amazon CloudWatch is a monitoring service for AWS resources and applications. It provides monitoring and logging capabilities, which can be used to collect, analyze, and act on metrics and log data from EKS clusters.

To configure EKS logging and monitoring using Fluent Bit, follow the steps below:

Step-1: Create a new Amazon EKS cluster or use an existing one

Step-2: Deploy Fluent Bit as a DaemonSet in the cluster. A DaemonSet ensures that a copy of a pod is running on each node in the cluster. Here's an example YAML file for deploying Fluent Bit

    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
    name: fluent-bit
    namespace: logging
    spec:
    selector:
        matchLabels:
        app: fluent-bit
    template:
        metadata:
        labels:
            app: fluent-bit
        spec:
        containers:
        - name: fluent-bit
            image: fluent/fluent-bit:latest
            env:
            - name: "FLUENT_UID"
            value: "0"
            - name: "FLUENTD_CONF"
            value: "fluent-bit.conf"
            volumeMounts:
            - name: fluent-bit-config
            mountPath: /fluent-bit/etc/
        volumes:
        - name: fluent-bit-config
            configMap:
            name: fluent-bit-config

Step-3: Create a ConfigMap that contains the Fluent Bit configuration file.

    apiVersion: v1
    kind: ConfigMap
    metadata:
    name: fluent-bit-config
    namespace: logging
    data:
    fluent-bit.conf: |
        [SERVICE]
            Flush        1
            Log_Level    info
            Parsers_File parsers.conf

        [INPUT]
            Name              tail
            Path              /var/log/containers/*.log
            Tag               kube.*
            Parser            docker
            DB                /var/log/flb_kube.db
            Mem_Buf_Limit     50MB
            Skip_Long_Lines   On
            Refresh_Interval  10

        [FILTER]
            Name                kubernetes
            Match               kube.*
            Kube_URL            https://kubernetes.default.svc:443
            Kube_CA_File        /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
            Kube_Token_File     /var/run/secrets/kubernetes.io/serviceaccount/token
            Merge_Log           On
            Merge_Log_Key       log_processed

        [OUTPUT]
            Name cloudwatch_logs
            Match *
            region <aws-region>
            log_group_name <log-group-name>
            log_stream_prefix <log-stream-prefix>
            auto_create_group true
            max_retry 5
            retry_limit 5
            retry_wait 

Step-4: Create the ConfigMap using the following command

    $ kubectl create configmap fluent-bit-config --from-file fluent-bit.conf

Step-5: Create a ClusterRole that allows Fluent Bit to read Kubernetes resources, such as pods and namespaces

    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRole
    metadata:
    name: fluent-bit-read
    rules:
    - apiGroups: [""]
    resources:
    - namespaces
    - pods
    verbs:
    - get
    - list
    - watch

Step-6: Bind the ClusterRole to the ServiceAccount

    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRoleBinding
    metadata:
    name: fluent-bit-read
    roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: fluent-bit-read
    subjects:
    - kind: ServiceAccount
    name: fluent-bit
    namespace: logging

Step-7: Deploy the ClusterRoleBinding

    $ kubectl apply -f fluent-bit-role.yaml

Step-8: Deploy Fluent Bit

    $ kubectl apply -f fluent-bit.yaml

Step-9: Verify that Fluent Bit is running

    $ kubectl get pods -n logging

Step-10: Create a log group in Amazon CloudWatch Logs

    $ aws logs create-log-group --log-group-name <log-group-name> --region <aws-region>

Step-11: Verify that logs are being sent to Amazon CloudWatch Logs

    $ aws logs describe-log-streams --log-group-name <log-group-name> --region <aws-region>

## Best Practices for Monitoring and Logging

- Define clear metrics: Before you begin using CloudWatch, define the metrics that you want to monitor. Be clear on the specific values that you need to track, such as CPU utilization, network traffic, or error rates. This will help you create better alarms and dashboards.

- Use namespaces and dimensions: Use namespaces and dimensions to organize and filter your metrics. Namespaces can help you distinguish between different applications or environments, while dimensions can provide additional context to your metrics.

- Choose appropriate data resolution: Choose the appropriate data resolution based on the frequency and granularity of your metrics. For example, if you need to monitor CPU utilization every minute, use a higher resolution than if you only need to monitor it every 5 minutes.

- Enable detailed monitoring: Enable detailed monitoring for instances and other resources that require high-resolution metrics. This will provide more granular data for your metrics.

- Use alarms to monitor metrics: Create alarms to monitor your metrics and notify you when a specific threshold is breached. This will help you take timely action to prevent issues or outages.

- Create custom metrics: Use CloudWatch APIs or CloudWatch Agent to create custom metrics for your applications.

- Define clear monitoring goals: Before you start using CloudWatch, it's important to define what you want to monitor and what metrics you want to track. This will help you avoid collecting unnecessary data and ensure that you're collecting the right data to help you troubleshoot issues.

- Set up proper permissions: Make sure you configure appropriate IAM roles and policies for users and services to access and interact with CloudWatch resources. This will help ensure security and prevent unauthorized access.

- Enable CloudWatch Logs for your EC2 instances: By enabling CloudWatch Logs for your EC2 instances, you can capture and store logs generated by your applications and operating system. This data can be used to troubleshoot issues and monitor performance

- Use CloudWatch Dashboards: Create dashboards to visualize and analyze your metrics in real-time. This can help you quickly identify issues and make informed decisions.

- Use CloudWatch Events to automate tasks: You can use CloudWatch Events to trigger automated responses to specific events. This can help you save time and improve efficiency

- Enable CloudWatch Agent on your instances: By installing and configuring the CloudWatch Agent on your instances, you can collect more detailed system-level metrics and logs.

- Set up cross-account CloudWatch monitoring: If you have multiple AWS accounts, you can set up cross-account CloudWatch monitoring to gain visibility into all your resources.

- Instrument all your application components: It is important to instrument all the components of your application, including front-end, back-end, and third-party services, to get a comprehensive view of your application's performance.

- Use tracing headers: Tracing headers such as X-Amzn-Trace-Id can be used to propagate trace information between services, enabling you to track the end-to-end flow of a request.

- Use annotations and metadata: Annotations and metadata can be used to add contextual information to traces, making it easier to understand and troubleshoot issues.

- Set sampling rules: Sampling rules can be used to control the amount of data that is collected, reducing the cost of tracing while still providing sufficient coverage.

- Analyze traces regularly: Regularly analyzing traces can help you identify performance bottlenecks and potential issues before they impact your users.

- Integrate with AWS services: AWS X-Ray can be integrated with other AWS services such as Amazon EC2, Amazon ECS, and AWS Lambda to provide deeper insights into the performance of your applications.

- Use X-Ray SDKs: X-Ray SDKs are available for popular programming languages such as Java, Python, and Node.js, making it easier to instrument your application components.

- Monitor error rates: Monitoring error rates can help you identify issues and improve the quality of your application.

- Use X-Ray with CloudWatch: Using X-Ray with CloudWatch can help you monitor the performance of your applications in real-time and set alarms to notify you of issues.

- Keep X-Ray updated: Keep your X-Ray libraries and agents updated to ensure that you are using the latest features and bug fixes.

- Define clear log collection requirements: Before configuring Fluent Bit, define what logs you want to collect, where they are located, and how often they should be collected. This will help you to optimize your Fluent Bit configuration and ensure that it is collecting the data you need.

- Configure log collection paths: Fluent Bit can collect logs from various sources, such as local files, standard input, or syslog. Specify the appropriate paths to collect logs from the sources you need.

- Set up log parsing: Fluent Bit can parse various log formats, including JSON, syslog, and Apache. Configure the appropriate parser to ensure that your logs are parsed correctly.

- Filter logs: Fluent Bit filters can be used to modify and enrich logs based on specific criteria. Use filters to remove unnecessary data or add additional metadata to your logs.

- Optimize performance: Fluent Bit performance can be optimized by configuring the number of workers and the buffer size. Experiment with these settings to find the optimal configuration for your needs.

- Set up log forwarding: Fluent Bit can forward logs to various destinations, such as Elasticsearch, AWS S3, or Kafka. Configure the appropriate destination and authentication settings to ensure that your logs are securely sent to the right location.

- Monitor Fluent Bit: Set up monitoring for Fluent Bit to ensure that it is running smoothly and collecting the expected logs. Fluent Bit provides several metrics that can be used to monitor its performance, including CPU usage, memory usage, and the number of processed records.

- Keep Fluent Bit up to date: Fluent Bit is an active project, and updates are regularly released to improve performance and fix bugs. Ensure that you are using the latest version to take advantage of the latest features and bug fixes.














