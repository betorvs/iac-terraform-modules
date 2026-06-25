resource "aws_iam_openid_connect_provider" "this" {
  url             = var.provider_url
  client_id_list  = var.provider_client_list
  thumbprint_list = var.provider_thumbprint_list
  tags            = var.tags
}

resource "aws_iam_role" "this" {
  name                 = var.role_name
  description          = var.role_description
  max_session_duration = var.max_session_duration
  assume_role_policy   = data.aws_iam_policy_document.this.json
  tags                 = var.tags
  depends_on           = [aws_iam_openid_connect_provider.this]
}

data "aws_iam_policy_document" "this" {

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = var.policy_condition_test
      values   = var.repositories
      variable = "token.actions.githubusercontent.com:sub"
    }

    condition {
      test     = var.policy_condition_test
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.this.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role_policy_attachment" "attach" {

  policy_arn = var.role_attach_policy_arn
  role       = aws_iam_role.this.name

  depends_on = [aws_iam_role.this]
}
