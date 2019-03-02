configure-arch : TAGS = --tags=$(tags)
configure-arch : ARGS = $(args)

configure-arch:
	ansible-playbook -i localhost configure.yml $(TAGS) $(ARGS)

lint:
	ansible-lint configure.yml
