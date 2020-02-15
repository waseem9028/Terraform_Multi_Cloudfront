// Setup the CloudFront Distribution

resource "aws_cloudfront_distribution" "cfd_id" {
  lifecycle {
    create_before_destroy = true
  }

  count = "${length(var.cfd_name)}"

  origin {
    domain_name = "${var.bucket_name}.s3.amazonaws.com"
    origin_id   = "S3-${var.bucket_name}/${element(var.cfd_name, count.index)}"
  }

  //Trying to get the elb name from cloudfront application TP

  data "aws_elb" "tp" {
    name = "${var.aws_elb_dns_name}" // Getting error here as name need to be spacify 

    filter {
      name  = "tag:elasticbeanstalk:environment-name" //applying filter to get exact loadbalancer
      value = "${var.stage}-${var.service}"
    }
  }

  //Setting for TP

  origin {
    domain_name = "${data.aws_elb.tp.id}"
    origin_id = "ELB-${replace("${data.aws_elb.tp.id}", ".eu-central-1.elb.amazonaws.com", "/tp.php")}" //Trying to set origin_id for tp.
  }
  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["${element(var.cfd_name, count.index)}-${var.bucket_name}"]
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn      = "${var.acm_certificate_arn}"
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }
  default_cache_behavior {
    allowed_methods = ["HEAD", "GET"]
    cached_methods  = ["HEAD", "GET"]
    compress        = false

    forwarded_values {
      cookies {
        forward = "none"
      }

      query_string = false
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    smooth_streaming       = false
    target_origin_id       = "S3-${var.bucket_name}/${element(var.cfd_name, count.index)}"
    viewer_protocol_policy = "allow-all"
  }
}
