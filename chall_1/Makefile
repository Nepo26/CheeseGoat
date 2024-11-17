APP_NAME:=chall_1
APP_PATH:=app

INFRA_DIR:="$(abspath $(CURDIR)/infra)"

TF_PLAN_DIR:="$(INFRA_DIR)/tmp/tfplan"
ENV:=""
IAM_USER:=""

include .env
export $(shell sed 's/=.*//' .env)



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

.PHONY: local
local:
	@echo "Setting AWS Vault credentials for IAM_USER=$(IAM_USER)"
	@# Using shell here so makefile wait for command end, this avoids exporting and empty file
	@eval export $$(aws-vault export --format=export-env $(IAM_USER))

.PHONY: fmt format
fmt:
	@echo "//TODO: fmt"
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" run-all fmt
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" hclfmt

.PHONY: apply
apply: get
	@echo "//TODO: create-infra"
	@terragrunt run-all apply \
		--terragrunt-working-dir "infra/environments/${ENV}"

.PHONY: plan
plan: get
	@echo "// TODO: plan"
	@terragrunt run-all plan \
		--terragrunt-working-dir "infra/environments/${ENV}" \
		--terragrunt-out-dir "$(TF_PLAN_DIR)"
#		--terragrunt-log-level trace --terragrunt-debug

.PHONY: show
show:
	@echo "// TODO: show"
	@terragrunt run-all show \
		--terragrunt-working-dir "infra/environments/${ENV}" \
		 "$(shell echo $(TF_PLAN_DIR)/**)"

.PHONY: graph-dependencies
graph-dependencies:
	@echo "// TODO; graph dependencies"
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" graph-dependencies
