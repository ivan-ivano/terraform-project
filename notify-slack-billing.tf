module "label_notify_slack_use1" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name    = "notify-slack-use1"
}

module "notify_slack_use1" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "6.6.0"

  providers = {
    aws = aws.use1
  }

  sns_topic_name               = module.label_notify_slack_use1.id
  iam_role_name_prefix         = module.label_notify_slack_use1.id
  lambda_function_name         = module.label_notify_slack_use1.id
  sns_topic_feedback_role_name = module.label_notify_slack_use1.id
  slack_webhook_url            = var.slack_webhook_url
  slack_channel                = "notifications"
  slack_username               = "reporter"
}


