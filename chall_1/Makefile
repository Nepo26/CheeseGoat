APP_NAME=chall_1
APP_PATH=app
ENV=""

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

.PHONY: get
get:
	@echo "//TODO: get"
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" run-all init
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" run-all get


.PHONY: fmt format
fmt:
	@echo "//TODO: fmt"
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" run-all fmt

.PHONY: create-infra
create-infra: get
	@echo "//TODO: create-infra"

.PHONY: plan
plan: get
	@echo "// TODO: plan"
	@terragrunt run-all plan \
		--terragrunt-working-dir "infra/environments/${ENV}" \
		--terragrunt-out-dir /tmp/tfplan

.PHONY: show
show:
	@echo "// TODO: plan"
	@terragrunt run-all show "/tmp/tfplan/**" --terragrunt-non-interactive
