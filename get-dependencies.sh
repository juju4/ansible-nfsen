#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.maxmind ] && git clone https://github.com/juju4/ansible-maxmind $rolesdir/juju4.maxmind
[ ! -d $rolesdir/juju4.fprobe ] && git clone https://github.com/juju4/ansible-fprobe $rolesdir/juju4.fprobe
[ ! -d $rolesdir/geerlingguy.mysql ] && git clone https://github.com/geerlingguy/ansible-role-mysql.git $rolesdir/geerlingguy.mysql
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.nfsen ] && ln -s ansible-nfsen $rolesdir/juju4.nfsen
[ ! -e $rolesdir/sfromm.nfsen ] && cp -R $rolesdir/ansible-nfsen $rolesdir/sfromm.nfsen

## don't stop build on this script return code
true

