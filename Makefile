.PHONY: tf-create-repository
tf-create-repository:
	@CLICOLOR_FORCE=1 gh act -j tf_create_repository -s GITHUB_TOKEN="$(shell gh auth token)" | grep --color=always -v '::debug'
