terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.61.0"
    }
  }
  required_version = ">= 1.7.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_route53_zone" "selected" {
  name = "sctp-sandbox.com."
}

resource "aws_route53_record" "example" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "cymbal"
  type    = "A"

  alias {
    name                   = "a0e7346d4525849beaa1edbf2f13767f-896374830.ap-southeast-1.elb.amazonaws.com"
    zone_id                = "Z1LMS91P8CMLE5"
    evaluate_target_health = false
  }
}
