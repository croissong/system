init:
	ansible-galaxy install -r requirements.yml

configure-dry:
	ansible-playbook -i localhost configure.yml --check --diff $(args)

configure:
	ansible-playbook -i localhost configure.yml $(args)

lint:
	ansible-lint configure.yml
