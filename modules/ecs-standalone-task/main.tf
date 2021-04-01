locals {

    # # Environment variables a format that AWS can understand.
    # env_vars_aws = [
    #     for key in keys(var.env_vars): {
    #         name = key
    #         value = var.env_vars[key]
    #     }
    # ]

    # # Secrets on a format that AWS can understand.
    # secrets_aws = [
    #     for key in keys(var.secrets): {
    #         name = key
    #         valueFrom = var.secrets[key]
    #     }
    # ]
}

variable "name" {
    type = string
    description = "Unique name of this task"
}

variable "environment" {
    type = string
    description = "Deployment environment which this task will be deployed to"
}

variable "cpu" {
    type = number
    description = "CPU"
    default = 1024
}

variable "memory" {
    type = number
    description = "Memory"
    default = 2048
}

variable "desired_count" {
    type = number
    description = "Desired number of nodes running tasks"
    default = 1
}

variable "min_capacity" {
    type = number
    description = "Minimum number of nodes running tasks"
    default = 1
}

variable "max_capacity" {
    type = number
    description = "Maximum number of nodes running tasks"
    default = 1
}

# variable "env_vars" {
#     description = "Environment variables to be sent to the container"
#     type = map(string)
#     default = {}
# }

# variable "secrets" {
#     description = "Secrets to be read by the container during the task deployment"
#     type = map(string)
#     default = {}
# }

variable "tasks" {
    description = "A simplified representation of the tasks that will be running by this task"
    type = list(object({
        name = string,
        image = string,
        env_vars = map(string),
        secrets = map(string),
        port_mappings = list(string)
    }))
}

variable "target_groups" {
    type = list(object({
        target_group_arn = string,
        container_name = string,
        container_port = number
    }))
    description = "List of Target Groups which will expose container ports to the world"
    default = []
}

variable "vpc_id" {
    type = string
    description = "The VPC ID"
}

variable "subnet_ids" {
    type = list(string)
    description = "List of subnet IDs this task should be using"
}