#!/usr/bin/env bash
 cat /etc/sysconfig/keyboard
ckbcomp -model 'pc105' -layout 'de' -option 'ctrl:nocaps' -variant 'nodeadkeys' | loadkeys
