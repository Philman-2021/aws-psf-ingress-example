variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "controller_ip" {
  type    = string
  default = ""
}

variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "psf_nlb_port" {
  description = "The port for the AWS NLB"
  type        = string
  default     = "22"
}

variable "psf_nlb_protocol" {
  description = "The protocol for the AWS NLB"
  type        = string
  default     = "TCP"
}