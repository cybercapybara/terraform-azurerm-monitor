output "action_group_id" {
  description = "ID of the monitor action group."
  value       = azurerm_monitor_action_group.this.id
}

output "action_group_name" {
  description = "Name of the monitor action group."
  value       = azurerm_monitor_action_group.this.name
}

output "metric_alert_ids" {
  description = "Map of metric alert names to their IDs."
  value       = { for k, v in azurerm_monitor_metric_alert.this : k => v.id }
}
