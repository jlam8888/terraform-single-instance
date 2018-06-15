# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

variable "aws_access_key" {
  default = "aws_access_key"
}

variable "aws_secret_key" {
  default = "aws_secret_key"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 80
}
variable "https_port" {
  description = "The port the server will use for HTTPS requests"
  default = 443
}
variable "ssh_port" {
  description = "The port the server will use for ssh"
  default = 22
}
