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
  default = "arn:aws:acm:us-east-1:821323231213:certificate/4114587e9-1262-12323-9da8-231231dsd2312"
}

variable "service" {
  type = "string"
}

variable "stage" {
  type = "string"
}

variable "lb_name" {
  type = "string"
  default = ""
}

variable "aws_elb_dns_name" {
  type = "string"
}
