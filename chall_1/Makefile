APP_NAME := "chall_1"
APP_PATH := "app"

INFRA_DIR := "$(abspath $(CURDIR)/infra)"

TF_PLAN_DIR := "$(INFRA_DIR)/tmp/tfplan"
ENV :=
IAM_USER :=
LOCAL ?= false


# Conditionally include .env file
-include .env

ifeq ($(LOCAL),true)
    # Only export .env variables if .env exists
    ifneq (,$(wildcard .env))
        include .env
        export $(shell sed 's/=.*//' .env)
    endif

    SHELL := aws-vault exec --server $(IAM_USER) -- /bin/bash
endif

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
	@echo "//TODO: get" >&2
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" run-all init
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" run-all get

.PHONY: debug-env
debug-env:
	@#env
	@aws sts get-caller-identity

.PHONY: fmt format
fmt:
	@echo "//TODO: fmt"
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" run-all fmt
	@terragrunt --terragrunt-working-dir "infra/environments/${ENV}" hclfmt

.PHONY: apply
apply: get
	@echo "//TODO: create-infra" >&2
	@terragrunt run-all apply \
		--terragrunt-working-dir "infra/environments/${ENV}"


.PHONY: apply-approved
apply-approved: get
	@echo "//TODO: apply-approved" >&2
	@terragrunt run-all apply -auto-approve \
  		--terragrunt-working-dir "infra/environments/${ENV}" \
  		--terragrunt-non-interactive

.PHONY: plan
plan: get
	@echo "// TODO: plan"
	@terragrunt run-all plan \
		--terragrunt-working-dir "infra/environments/${ENV}" \
		--terragrunt-out-dir "$(TF_PLAN_DIR)"
#		--terragrunt-log-level trace --terragrunt-debug


.PHONY: output
output: get
	@echo "// TODO: Output">&2
	@terragrunt run-all refresh \
		--terragrunt-working-dir "infra/environments/${ENV}"
	@terragrunt run-all output -json \
		--terragrunt-working-dir "infra/environments/${ENV}"

.PHONY: destroy
destroy: get
	@echo "// TODO: destroy"
	@terragrunt run-all destroy \
		--terragrunt-working-dir "infra/environments/${ENV}" \
		--terragrunt-out-dir "$(TF_PLAN_DIR)"


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
