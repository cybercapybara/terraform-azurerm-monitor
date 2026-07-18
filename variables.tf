variable "name" {
  description = "Name of the monitor action group."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the monitor resources."
  type        = string
}

variable "short_name" {
  description = "Short name of the action group, used as the sender in notifications. Maximum 12 characters."
  type        = string

  validation {
    condition     = length(var.short_name) >= 1 && length(var.short_name) <= 12
    error_message = "The short_name must be between 1 and 12 characters."
  }
}

variable "email_receivers" {
  description = "Map of email receivers for the action group, keyed by receiver name."
  type = map(object({
    email_address           = string
    use_common_alert_schema = optional(bool, true)
  }))
  default = {}
}

variable "metric_alerts" {
  description = "Map of metric alerts to create, keyed by alert name. Each alert targets the given scopes and fires the action group."
  type = map(object({
    description      = optional(string, null)
    scopes           = list(string)
    severity         = optional(number, 3)
    frequency        = optional(string, "PT1M")
    window_size      = optional(string, "PT5M")
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
  }))
  default = {}
}

variable "tags" {
  description = "Map of tags applied to the monitor resources."
  type        = map(string)
  default     = {}
}
