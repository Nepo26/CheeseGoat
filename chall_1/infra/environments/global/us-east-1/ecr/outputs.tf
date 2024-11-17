output "ecr_name" {
  value = module.shared_ecr.repository_name
  description = "The name of the ecr repository"
}
