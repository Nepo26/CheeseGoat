.PHONY: tf-create-repository
tf-create-repository:
	@CLICOLOR_FORCE=1 gh act -j tf_create_repository -s GITHUB_TOKEN="$(shell gh auth token)" --secret-file "my.secrets" | grep --color=always -v '::debug'

.PHONY: debug
debug:
	@CLICOLOR_FORCE=1 gh act -j tf_create_repository -s GITHUB_TOKEN="$(shell gh auth token)" --secret-file "my.secrets"
