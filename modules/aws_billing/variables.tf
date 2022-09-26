variable "monthly_budget_name" {
  type    = string
  default = ""
}

variable "monthly_budget" {
  type    = number
}

variable "subscriber_email_list" {
  type    = list(any)
  default = [""]
}

variable "first_alert" {
  type    = number
    default = 75
}

variable "second_alert" {
  type    = number
  default = 90
}

variable "exhausted_threshold_percent" {
  type    = number
  default = 100
}
