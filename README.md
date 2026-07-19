# terraform-azurerm-monitor

Terraform module that manages [Azure Monitor](https://azure.microsoft.com/products/monitor)
alerting. It creates an action group with optional email receivers and, driven
by an input map, a set of metric alerts that notify that action group when a
metric crosses a threshold.

## Usage

```hcl
module "monitor" {
  source = "github.com/moveeeax/terraform-azurerm-monitor"

  name                = "prod-ag"
  resource_group_name = "prod-rg"
  short_name          = "prodag"

  email_receivers = {
    "oncall" = { email_address = "oncall@example.com" }
  }

  metric_alerts = {
    "cpu-high" = {
      scopes           = ["/subscriptions/xxxx/resourceGroups/prod-rg/providers/Microsoft.Compute/virtualMachines/vm1"]
      metric_namespace = "Microsoft.Compute/virtualMachines"
      metric_name      = "Percentage CPU"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 80
    }
  }

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

A runnable example lives in [`examples/basic`](examples/basic).

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5   |
| azurerm   | >= 3.0   |

## Inputs

| Name                  | Description                                                            | Type          | Default | Required |
|-----------------------|------------------------------------------------------------------------|---------------|---------|:--------:|
| `name`                | Name of the monitor action group.                                      | `string`      | n/a     |   yes    |
| `resource_group_name` | Name of the resource group in which to create the monitor resources.   | `string`      | n/a     |   yes    |
| `short_name`          | Short name of the action group (max 12 chars).                         | `string`      | n/a     |   yes    |
| `email_receivers`     | Map of email receivers keyed by receiver name.                         | `map(object)` | `{}`    |    no    |
| `metric_alerts`       | Map of metric alerts keyed by alert name.                              | `map(object)` | `{}`    |    no    |
| `tags`                | Map of tags applied to the monitor resources.                          | `map(string)` | `{}`    |    no    |

## Outputs

| Name                | Description                                  |
|---------------------|----------------------------------------------|
| `action_group_id`   | ID of the monitor action group.              |
| `action_group_name` | Name of the monitor action group.            |
| `metric_alert_ids`  | Map of metric alert names to their IDs.      |

## License

[MIT](LICENSE)
