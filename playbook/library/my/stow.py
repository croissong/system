#!/usr/bin/python
from ansible.module_utils.basic import AnsibleModule
import re

DOCUMENTATION = '''
---
module: stow
short_description: Manage links to dotfiles
'''

changed_stdout_pattern = re.compile("^LINK.*", re.MULTILINE)
target_dirs = {'home': '$USER_HOME', 'root': '/'}

def stow(module):
    params = module.params
    package = params['package']
    source_dir = params['source_dir']
    target_dir = target_dirs[params['target_dir']]

    cmd = f'stow -v 2 -d {source_dir} -t {target_dir} -S {package}'
    rc, stdout, stderr = module.run_command(cmd, check_rc=False)
    
    if rc == 0:
        changed = changed_stdout_pattern.search(stderr) is not None
        module.exit_json(changed=changed, stderr=stderr)
    else:
        module.fail_json(msg=f'failed to stow ( {cmd} ) {stderr}')

def main():
    module = AnsibleModule(
        argument_spec = dict(
            package=dict(required=True),
            source_dir=dict(required=False, default='$DOTFILES_DIR'),
            target_dir=dict(default='home', choices=['home', 'root'])
        )
    )

    stow(module)


if __name__ == '__main__':
    main()
