terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}

provider "aws" {
  region = "us-east-1" # Billing metrics are only in us-east-1 for many accounts
}

variable "prefix" {
  default = "Akshay_Kumar"
}

# CloudWatch Alarm for Estimated Charges
resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "${var.prefix}_Billing_Alarm_INR100"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600 # 6 hours
  statistic           = "Maximum"
  threshold           = 100
  dimensions = {
    Currency = "INR"
  }
  alarm_description = "Alert when estimated charges exceed INR 100"
  treat_missing_data = "notBreaching"
}
