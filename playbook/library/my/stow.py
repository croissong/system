#!/usr/bin/python

DOCUMENTATION = '''
---
module: stow
short_description: Manage links to dotfiles
'''

from ansible.module_utils.basic import *
import re


changed_stdout_pattern = re.compile("^LINK.*", re.MULTILINE)
target_dirs = {'home': '$HOME', 'root': '/'}

def stow(module):
    params = module.params
    package = params['package']
    source = params['dotfiles_dir']
    target = target_dirs[params['target']]

    cmd = f'stow -v 2 -d {source} -t {target} -S {package}'
    rc, stdout, stderr = module.run_command(cmd, check_rc=False)
    
    if rc == 0:
        changed = changed_stdout_pattern.search(stderr) is not None
        module.exit_json(changed=changed, stderr=stderr)
    else:
        module.fail_json(msg="failed to stow ( {} ) {}: {}".format(cmd, name, stderr))

def main():
    module = AnsibleModule(
        argument_spec = dict(
            package=dict(required=True),
            dotfiles_dir=dict(required=False, default='$HOME/dotfiles'),
            target=dict(default='home', choices=['home', 'root'])
        )
    )

    stow(module)


if __name__ == '__main__':
    main()
