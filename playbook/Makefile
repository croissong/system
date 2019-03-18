configure-arch : TAGS = --tags=$(tags)
configure-arch : ARGS = $(args)

configure:
	ansible-galaxy install -r requirements.yml

configure-arch:
	ansible-playbook -i localhost configure.yml $(TAGS) $(ARGS)

lint:
	ansible-lint configure.yml
