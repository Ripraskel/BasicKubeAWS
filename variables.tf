##
# Environment Variables
##
#
variable "environment" {
  type    = string
  default = "dev"
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "zones" {
  type = map
  default = {
    "a" = "eu-west-2a"
    "b" = "eu-west-2b"
    "c" = "eu-west-2c"
  }
}

variable "cluster-name" {
  type = string
  default = "basic-eks"
}
