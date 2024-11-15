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
	@terragrunt --terragrunt-working-dir infra/environments/dev plan -out=./plan.tfplan

.PHONY: graph-infra
graph-infra: create-infra
	@echo "// TODO: graph-infra"
	@terragrunt --terragrunt-working-dir infra/environments/dev graph -draw-cycles -plan=./plan.tfplan
	@#terragrunt --terragrunt-working-dir infra/environments/dev show -json ./plan.tfplan > ./plan.json



