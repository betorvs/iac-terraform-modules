provider "aws" {
  region                      = "us-east-1"
  access_key                  = "111111111111"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    acm             = "http://localhost:4566"
    apigateway      = "http://localhost:4566"
    appsync         = "http://localhost:4566"
    athena          = "http://localhost:4566"
    cloudformation  = "http://localhost:4566"
    cloudfront      = "http://localhost:4566"
    cloudwatch      = "http://localhost:4566"
    codebuild       = "http://localhost:4566"
    cognitoidentity = "http://localhost:4566"
    cognitoidp      = "http://localhost:4566"
    dynamodb        = "http://localhost:4566"
    ec2             = "http://localhost:4566"
    ecr             = "http://localhost:4566"
    ecs             = "http://localhost:4566"
    efs             = "http://localhost:4566"
    elasticache     = "http://localhost:4566"
    elbv2           = "http://localhost:4566"
    emr             = "http://localhost:4566"
    events          = "http://localhost:4566"
    firehose        = "http://localhost:4566"
    glue            = "http://localhost:4566"
    iam             = "http://localhost:4566"
    kinesis         = "http://localhost:4566"
    kms             = "http://localhost:4566"
    lambda          = "http://localhost:4566"
    logs            = "http://localhost:4566"
    rds             = "http://localhost:4566"
    route53         = "http://localhost:4566"
    s3              = "http://localhost:4566"
    s3control       = "http://localhost:4566"
    secretsmanager  = "http://localhost:4566"
    ses             = "http://localhost:4566"
    sesv2           = "http://localhost:4566"
    sns             = "http://localhost:4566"
    sqs             = "http://localhost:4566"
    ssm             = "http://localhost:4566"
    stepfunctions   = "http://localhost:4566"
    sts             = "http://localhost:4566"
    wafv2           = "http://localhost:4566"
  }
}

run "apply" {
  command = apply

  variables {
    role_attach_policy_arn = "arn:aws:iam::111111111111:policy/github-oidc-policy"

    role_description = "github oidc role test"

    repositories = [
      "repo:betorvs/iac-terraform-modules:ref:refs/heads/main"
    ]
  }

  assert {
    condition     = aws_iam_role.this.arn == "arn:aws:iam::111111111111:role/github-oidc-role-deployer"
    error_message = "Invalid Role ARN"
  }
}
