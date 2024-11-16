APP_NAME=chall_1
APP_PATH=app

.PHONY: build-container
build-container:
	@docker build -t "${APP_NAME}" "${APP_PATH}"

.PHONY: verify
verify:
	@echo "Verifying structure"
	@hadolint "${APP_PATH}/Dockerfile"
	@echo "Done"

.PHONY: publish
publish:
	@echo "//TODO: publish"

.PHONY: create-infra
create-infra:
	@echo "//TODO: create-infra"
	@terragrunt --terragrunt-working-dir infra/environments/dev run-all init
	@terragrunt --terragrunt-working-dir infra/environments/dev run-all get

.PHONY: plan
plan: create-infra
	@echo "// TODO: plan"
	@terragrunt run-all plan --terragrunt-working-dir infra/environments/dev --terragrunt-out-dir /tmp/tfplan

.PHONY: show
show:
	@echo "// TODO: plan"
	@terragrunt run-all show /tmp/tfplan/** --terragrunt-non-interactive
