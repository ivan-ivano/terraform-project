module "label_alarm" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name    = "alarm"
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = module.label_alarm.id
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  dimensions = {
  FunctionName = "dev-lpnu-2025-delete-course"
  Resource     = "dev-lpnu-2025-delete-course"

  }
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = 2
  alarm_description         = "This metric monitors delete course lambda function"
  insufficient_data_actions = []
  treat_missing_data        = "notBreaching"
#   alarm_actions             = ["arn:aws:sns:eu-central-1:140023374648:dev-lpnu-2025-notify-slack"]
  alarm_actions             = [module.notify_slack.slack_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  provider = aws.use1
  alarm_name          = "billing-alarm-over-1-dollar"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600
  statistic           = "Maximum"
  threshold           = 2.00
  alarm_description   = "Alarm when AWS charges exceed $1"
  treat_missing_data  = "notBreaching"

  dimensions = {
    Currency = "USD"
  }

  alarm_actions = [module.notify_slack_use1.slack_topic_arn]
}
