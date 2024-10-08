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

resource "aws_route53_record" "cymbal" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "cymbal"
  type    = "A"

  alias {
    name                   = "a1de2e754e7c04da480fb7ef4e96c4ae-959454185.ap-southeast-1.elb.amazonaws.com"
    zone_id                = "Z1LMS91P8CMLE5"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "caa" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = data.aws_route53_zone.selected.name
  type    = "CAA"
  ttl     = 60
  records = ["0 issue \"amazon.com\"", "128 issue \"letsencrypt.org\""]
}
