### POLICY TO MANAGE TERRAFORM STATE
module "policy_state_admin" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy_state_admin"

  path        = "/sre/tf/"
  description = "Allow to manage terraform state"

  policy = data.aws_iam_policy_document.tf_state_admin_permissions.json
}

# TODO Limit and specify exactly the state resources
data "aws_iam_policy_document" "tf_state_admin_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "dynamodb:*",
    ]
    resources = ["*"]
  }
}

### POLICY TO MANAGE ECR

module "policy_manage_ecr" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy_manage_ecr"
  path        = "/sre/ecr/"
  description = "Allow to create, manage, and describe ECR repositories and images"

  policy = data.aws_iam_policy_document.manage_ecr_permissions.json
}

data "aws_iam_policy_document" "manage_ecr_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:CreateRepository",
      "ecr:DeleteRepository",
      "ecr:DescribeRepositories",
      "ecr:PutImage",
      "ecr:BatchGetImage",
      "ecr:BatchDeleteImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:ListTagsForResource",
      "ecr:SetRepositoryPolicy",
      "ecr:PutLifecyclePolicy"
    ]
    resources = ["*"]
  }
}


### POLICY TO CREATE DATABASES
module "policy_manage_databases" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy_manage_databases"
  path        = "/sre/db/"
  description = "Allow to create and manage RDS databases"

  policy = data.aws_iam_policy_document.create_databases_permissions.json
}

data "aws_iam_policy_document" "create_databases_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "rds:CreateDBInstance",
      "rds:DeleteDBInstance",
      "rds:ModifyDBInstance",
      "rds:DescribeDBInstances",
    ]
    resources = ["*"]
  }
}

### POLICY TO CREATE SQS AND SNS
module "policy_manage_sqs_sns" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy_manage_sqs_sns"
  path        = "/sre/messaging/"
  description = "Allow to create and manage SQS and SNS topics and queues"

  policy = data.aws_iam_policy_document.create_sqs_sns_permissions.json
}

data "aws_iam_policy_document" "create_sqs_sns_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:CreateQueue",
      "sqs:DeleteQueue",
      "sqs:ListQueues",
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:ListTopics",
    ]
    resources = ["*"]
  }
}

### POLICY TO CREATE CLOUDFRONT
module "policy_manage_cloudfront" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy_manage_cloudfront"
  path        = "/sre/cdn/"
  description = "Allow to create and manage CloudFront distributions"

  policy = data.aws_iam_policy_document.create_cloudfront_permissions.json
}

data "aws_iam_policy_document" "create_cloudfront_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "cloudfront:CreateDistribution",
      "cloudfront:UpdateDistribution",
      # Probably disable cloudfront deletion to avoid bigger
      "cloudfront:DeleteDistribution",
      "cloudfront:GetDistribution",
    ]
    resources = ["*"]
  }
}

### POLICY TO SET ROUTE 53
module "policy_manage_route53" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy_manage_route53"
  path        = "/sre/dns/"
  description = "Allow to create and manage Route 53 records and hosted zones"

  policy = data.aws_iam_policy_document.set_route53_permissions.json
}

data "aws_iam_policy_document" "set_route53_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "route53:CreateHostedZone",
      "route53:DeleteHostedZone",
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
    ]
    resources = ["*"]
  }
}


### POLICY TO CREATE EKS CLUSTERS
module "policy_manage_eks_clusters" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy_manage_eks_clusters"
  path        = "/sre/eks/"
  description = "Allow to create and manage EKS clusters"

  policy = data.aws_iam_policy_document.create_eks_clusters_permissions.json
}

data "aws_iam_policy_document" "create_eks_clusters_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "eks:CreateCluster",
      "eks:DeleteCluster",
      "eks:DescribeCluster",
      "eks:UpdateClusterConfig",
    ]
    resources = ["*"]
  }
}

