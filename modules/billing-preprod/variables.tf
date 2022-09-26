variable "monthly_budget_name" {
  type    = string
  default = "cost-usage-report"
}

variable "monthly_budget" {
  type    = string
  default = "10"
}

variable "subscriber_email_list" {
  type    = list(any)
  default = ["manojgoyal.agarwal@gmail.com"]
}

variable "first_alert" {
  type    = string
  default = "75"
}

variable "second_alert" {
  type    = string
  default = "90"
}

variable "exhausted_threshold_percent" {
  type    = string
  default = "100"
}
