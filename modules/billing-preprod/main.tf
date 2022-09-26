module "ec2module" {
  source                = "../../modules/aws_billing"
  monthly_budget_name   = var.monthly_budget_name
  monthly_budget        = var.monthly_budget
  subscriber_email_list = var.subscriber_email_list
  first_alert = var.first_alert
  second_alert = var.second_alert
  exhausted_threshold_percent = var.exhausted_threshold_percent
}