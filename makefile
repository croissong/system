configure:
	ansible-playbook -i localhost configure.yml

lint:
	$(MAKE) -C playbook lint
