//Variable declaration for CloudFront Distributions
# variable "cfd_id" {
#   type = "list"
#   default = [""]
# }

variable "cfd_name" {
  type    = "list"
  default = [""]
}

variable "bucket_name" {
  type = "string"
}

variable "acm_certificate_arn" {
  type    = "string"
  default = "arn:aws:acm:us-east-1:849270548413:certificate/44a687e9-5062-4159-9da8-9bf0d551cc3a"
}

variable "service" {
  type = "string"
}

variable "stage" {
  type = "string"
}

variable "lb_name" {
  type = "string"

  #  default = "awseb-e-i-AWSEBLoa-BO31HWFDQYR3"
  default = ""
}

variable "aws_elb_dns_name" {
  type = "string"
}
