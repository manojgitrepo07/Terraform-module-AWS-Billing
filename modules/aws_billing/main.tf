resource "aws_budgets_budget" "monthly" {
  name         = var.monthly_budget_name
  budget_type  = "COST"
  limit_amount = var.monthly_budget
  limit_unit   = "USD"

  # "If you didn't specify an end date, AWS set your end date to 06/15/87 00:00 UTC."
  time_period_end = "2087-06-15_00:00"

  # Start is required
  time_period_start = "2021-08-01_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.first_alert
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.subscriber_email_list
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.second_alert
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.subscriber_email_list
  }
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.exhausted_threshold_percent
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.subscriber_email_list
  }
}

resource "aws_s3_bucket" "cost-usage-report" {
  bucket = "vori-cost-usage-report"
  acl    = "private"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }


  tags = {
    stack-name    = "cost-usage-report"
    logical-id    = "S3Bucket"
    functionality = "storage"
    env           = "allenv"
    region        = "us-east-1"
  }

}

resource "aws_s3_bucket_public_access_block" "private_bucket" {
  bucket = "vori-cost-usage-report"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cur_report_definition" "example_cur_report_definition" {
  report_name                = "cost-usage-report"
  time_unit                  = "DAILY"
  format                     = "textORcsv"
  compression                = "ZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = "vori-cost-usage-report"
  s3_region                  = "us-east-1"
}


