#
#  Configuration for AWS swarm
#
# node definitions
declare MACHINE_NAME=''
declare MACHINE_TYPE='aws'
declare -i MANAGERS=1
declare -i WORKERS=2

# holders for the rendered nodes
# global throughout all routine modules
declare -a NAMES=(
  "mgr1"
  "wrk1"
  "wrk2"
)

declare -A NODES=(
  ["mgr1"]='manager'
  ["wrk1"]='worker'
  ["wrk2"]='worker'
)

declare LEADER_IP=''
declare LEADER_PORT='2377'
declare WORKER_TOKEN=''
declare MANAGER_TOKEN=''

declare SERVICE_NAME=''
declare SERVICE_IMAGE=''
declare REPLICAS=2

# AWS MACHINE configuration
# for lookup
declare REGION='us-west-2'
declare VPC_NAME='xybersolve-prod'
declare SECURITY_GROUP='swarm-sg'
declare OS='trusty'
declare IMAGE_OS='trusty'
declare ZONE='a'

# pre-determined
declare VPC_ID='vpc-a50b45dc'
declare SUBNET_ID='subnet-e55583ae'
declare SECURITY_GROUP_ID='' # sg name is used
declare REMOTE_USER='ubuntu'
declare IMAGE_ID='' # lookup up at time of creation
declare INSTANCE_TYPE='t2.micro'
declare TAG_NAME='' # uses node name
declare ROOT_SIZE=10
declare SSH_KEYPAIR='transible-key'
declare SSH_KEYPATH=~/.ssh/transible-key

# virtualbox nodes
# declare -a NAMES=(
#   'node1'
#   'node2'
#   'node3'
# )
# declare -A NODES=(
#   ['node1']='leader'
#   ['node2']='manager'
#   ['node3']='worker'
#   ['node4']='worker'
# )


# AWS nodes
# declare -a NAMES=(
#   'aws01'
#   'aws02'
#   'aws03'
# )
#
# declare -A NODES=(
#   ['aws01']='manager'
#   ['aws02']='worker'
#   ['aws03']='worker'
# )
