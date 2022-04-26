#
#  Configuration for swarm scripts
#
# node definitions, which swarm are we working on
declare OS=$(uname -s)
declare MACHINE_TYPE_TO_USE=''

[[ "${OS}" == 'Darwin' ]] \
  && MACHINE_TYPE_TO_USE='vbx' \
  || MACHINE_TYPE_TO_USE='aws'

# hard code to override
MACHINE_TYPE_TO_USE='aws'
