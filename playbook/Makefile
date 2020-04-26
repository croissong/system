init:
	ansible-galaxy install -r requirements.yml

configure-dry:
	ansible-playbook -i localhost configure.yml --check --diff $(args)

configure:
	ansible-playbook -i localhost configure.yml --diff $(args)

lint:
	ansible-lint configure.yml
