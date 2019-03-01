#!/usr/bin/python

DOCUMENTATION = '''
---
module: stow
short_description: Manage links to dotfiles
'''

from ansible.module_utils.basic import *
import re


changed_stdout_pattern = re.compile("^LINK.*", re.MULTILINE)

def stow(module):
    params = module.params
    state = params['state']
    package = params['package']
    source_dir = params['source_dir']
    target_dir = params['target_dir']

    cmd = "stow -v 2 -d {} -t {} -S {}".format(source_dir, target_dir, package)

    rc, stdout, stderr = module.run_command(cmd, check_rc=False)
    
    if rc == 0:
        changed = changed_stdout_pattern.search(stderr) is not None
        module.exit_json(changed=changed, stderr=stderr)
    else:
        module.fail_json(msg="failed to stow ( {} ) {}: {}".format(cmd, name, stderr))

def main():
    module = AnsibleModule(
        argument_spec = dict(
            state=dict(default='present', choices=['present', 'absent']),
            package=dict(required=True),
            source_dir=dict(required=True),
            target_dir=dict(required=True),
            use=dict(default='stow')
        )
    )

    stow(module)


if __name__ == '__main__':
    main()
