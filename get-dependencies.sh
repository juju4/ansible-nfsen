#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.maxmind ] && git clone https://github.com/juju4/ansible-maxmind $rolesdir/juju4.maxmind
[ ! -d $rolesdir/geerlingguy.mysql ] && git clone https://github.com/geerlingguy/ansible-role-mysql.git $rolesdir/geerlingguy.mysql

