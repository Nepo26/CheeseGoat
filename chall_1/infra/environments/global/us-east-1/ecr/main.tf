module "shared_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "${var.project_name}-${var.environment}-shared-ecr"
  # TODO Define read write based on groups
  repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  create_lifecycle_policy = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_force_delete = false

  // TODO Enable image scan on push
  repository_image_scan_on_push = false

  // TODO Define a KMS Key, needs to define KMS first
  repository_kms_key = null
}
