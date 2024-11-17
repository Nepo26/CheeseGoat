.PHONY: tf-create-repository
tf-create-repository:
	@$(MAKE) debug | grep --color=always -v '::debug'

.PHONY: debug
debug:
	@gh act -j tf_create_repository -s GITHUB_TOKEN="$(shell gh auth token)" --secret-file "my.secrets" -P "ubuntu-latest=nektos/act-environments-ubuntu:18.04"
