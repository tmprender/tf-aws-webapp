##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  type        = string
  description = "This prefix will be included in the name of most resources."
}

variable "region" {
  type        = string
  description = "The region where the resources are created."
  default     = "eu-west-1"
}

variable "env" {
  type        = string
  description = "Value for the environment tag."
}

variable "packer_bucket" {
  type        = string
  description = "HCP Packer bucket name containing the source image."
  default     = "ubuntu-focal-webserver"
}

variable "packer_channel" {
  type        = string
  description = "HCP Packer image channel."
  default     = "production"
}

variable "address_space" {
  type        = string
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  type        = string
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  type        = string
  description = "Specifies the AWS instance type."
  default     = "t3.micro"
}

variable "assign_eip" {
  type        = bool
  description = "Whether to assign a static Elastic IP address"
  default     = false
}
