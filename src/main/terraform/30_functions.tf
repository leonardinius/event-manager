
resource "aws_lambda_function" "copy_contacts_from_event_brite_to_send_grid_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "copy_contacts_from_event_brite_to_send_grid_function"
  description             = "Copy Contacts From Event Brite To Send Grid"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.CopyContactsFromEventBriteToSendGrid::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "copy_contacts_from_event_brite_to_send_grid_function_alias" {
  name                    = "copy_contacts_from_event_brite_to_send_grid_function_latest"
  function_name           = "${aws_lambda_function.copy_contacts_from_event_brite_to_send_grid_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "create_new_event_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "create_new_event_function"
  description             = "Create New Event"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.CreateNewEvent::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "create_new_event_function_alias" {
  name                    = "create_new_event_function_latest"
  function_name           = "${aws_lambda_function.create_new_event_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "list_event_brite_venues_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "list_event_brite_venues_function"
  description             = "List Event Brite Venues"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.ListEventBriteVenues::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "list_event_brite_venues_function_alias" {
  name                    = "list_event_brite_venues_function_latest"
  function_name           = "${aws_lambda_function.list_event_brite_venues_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "list_send_grid_suppressed_emails_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "list_send_grid_suppressed_emails_function"
  description             = "List Send Grid Suppressed Emails"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.ListSendGridSuppressedEmails::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "list_send_grid_suppressed_emails_function_alias" {
  name                    = "list_send_grid_suppressed_emails_function_latest"
  function_name           = "${aws_lambda_function.list_send_grid_suppressed_emails_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "publish_announcement_on_twitter_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "publish_announcement_on_twitter_function"
  description             = "Publish Announcement On Twitter"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.PublishAnnouncementOnTwitter::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "publish_announcement_on_twitter_function_alias" {
  name                    = "publish_announcement_on_twitter_function_latest"
  function_name           = "${aws_lambda_function.publish_announcement_on_twitter_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "publish_campaign_on_send_grid_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "publish_campaign_on_send_grid_function"
  description             = "Publish Campaign On Send Grid"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.PublishCampaignOnSendGrid::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "publish_campaign_on_send_grid_function_alias" {
  name                    = "publish_campaign_on_send_grid_function_latest"
  function_name           = "${aws_lambda_function.publish_campaign_on_send_grid_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "publish_cards_on_s3_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "publish_cards_on_s3_function"
  description             = "Publish Cards On S3"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.PublishCardsOnS3::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "publish_cards_on_s3_function_alias" {
  name                    = "publish_cards_on_s3_function_latest"
  function_name           = "${aws_lambda_function.publish_cards_on_s3_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "publish_event_on_event_brite_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "publish_event_on_event_brite_function"
  description             = "Publish Event On Event Brite"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.PublishEventOnEventBrite::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "publish_event_on_event_brite_function_alias" {
  name                    = "publish_event_on_event_brite_function_latest"
  function_name           = "${aws_lambda_function.publish_event_on_event_brite_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "publish_event_on_lanyrd_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "publish_event_on_lanyrd_function"
  description             = "Publish Event On Lanyrd"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.PublishEventOnLanyrd::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "publish_event_on_lanyrd_function_alias" {
  name                    = "publish_event_on_lanyrd_function_latest"
  function_name           = "${aws_lambda_function.publish_event_on_lanyrd_function.arn}"
  function_version        = "$LATEST"
}


resource "aws_lambda_function" "send_campaign_on_send_grid_function" {
  s3_bucket               = "${aws_s3_bucket.latcraft_code.bucket}"
  s3_key                  = "event-manager.zip"
  function_name           = "send_campaign_on_send_grid_function"
  description             = "Send Campaign On Send Grid"
  role                    = "${aws_iam_role.latcraft_lambda_executor.arn}"
  handler                 = "${var.lambda_code_package_prefix}.SendCampaignOnSendGrid::${var.lambda_code_default_method}"
  runtime                 = "java8"
  memory_size             = "512"
  timeout                 = "300"
  kms_key_arn             = "${aws_kms_key.latcraft_kms_key.arn}"
  environment {
    variables = {
      HOME                = "/var/task"
      JAVA_FONTS          = "/var/task/fonts"
    }
  }
}

resource "aws_lambda_alias" "send_campaign_on_send_grid_function_alias" {
  name                    = "send_campaign_on_send_grid_function_latest"
  function_name           = "${aws_lambda_function.send_campaign_on_send_grid_function.arn}"
  function_version        = "$LATEST"
}

