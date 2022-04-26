#
#  Configuration for Virtualbox swarm
#
# node definitions
declare MACHINE_TYPE='vbx'
declare MACHINE_NAME=''
#declare -i MANAGERS=2
#declare -i WORKERS=4
declare LEADER='mgr1'

# virtualbox nodes
declare -a NAMES=(
   'mgr1'
   'mgr2'
#   'mgr3'
   'wrk1'
   'wrk2'
   'wrk3'
   'wrk4'
#   'wrk5'
)
declare -A NODES=(
   ['mgr1']='manager'
   ['mgr2']='manager'
#   ['mgr3']='manager'
   ['wrk1']='worker'
   ['wrk2']='worker'
   ['wrk3']='worker'
   ['wrk4']='worker'
#   ['wrk5']='worker'
)

# global variables, across modules
#
declare LEADER_IP=''
declare LEADER_PORT='2377'
declare WORKER_TOKEN=''
declare MANAGER_TOKEN=''

declare SERVICE_NAME=''
declare SERVICE_IMAGE=''
