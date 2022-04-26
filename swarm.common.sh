#
#  Routines shared by swarm scripts
#
declare DIVIDER='****************************************'
declare SEPARATOR='----------------------------------------'
declare NODE_TYPE=''
declare _xsRESET='\e[0m'
declare _xsDEFAULT='\e[39m'
declare _xsRED='\e[31m'
declare _xsGREEN='\e[32m'
declare _xsYELLOW='\e[33m'
declare _xsBLUE='\e[34m'
declare _xsMAGENTA='\e[35m'
declare _xsCYAN='\e[36m'
declare _xsLIGHTGRAY='\e[37m'
declare _xsDARKGRAY='\e[90m'
declare _xsLIGHTRED='\e[91m'
declare _xsLIGHTGREEN='\e[92m'
declare _xsLIGHTYELLOW='\e[93m'
declare _xsLIGHTBLUE='\e[94m'
declare _xsLIGHTMAGENTA='\e[95m'
declare _xsLIGHTCYAN='\e[96m'
declare _xsWHITE='\e[97m'

__allocate_nodes() {
  #
  # renders node array from variable definitions
  #
  local -i i
  for ((i=1; i <= MANAGERS; i++)); do
    local name="${PREFIX}${i}"
    local name="${PREFIX}-mgr-0${i}"
    echo "${name}"
    NAMES+=( "${name}" )
    NODES["${name}"]='manager'
  done

  for ((i = 1; i <= WORKERS; i++)); do
    #local name="${PREFIX}${i}"
    local name="${PREFIX}-wrk-0${i}"
    NAMES+=( "${name}" )
    NODES["${name}"]='worker'
  done

  echo "Allocated Nodes:"
  for name in ${NAMES[@]}; do
    echo "${name}: ${NODES[${name}]}"
  done
}


__become() {
  # configure docker as manager node machine
  # __become - with no argument, means become leader
  local node=${1:-${NAMES[0]}}
  #echo "become: ${node}"
  eval $(docker-machine env "${node}")
  #  || echo "No docker-machine, assuming other means"
}

__ip() {
  docker-machine ip "${NAMES[0]}"
}

__clean_client_env() {
  # unset DOCKER HOST variables
  eval $(docker-machine env -u)
}

__set_completion() {
  curl -ksSL https://raw.githubusercontent.com/docker/docker/$(docker --version \
    | awk 'NR==1{print $NF}')/contrib/completion/bash/docker \
    | sudo tee /etc/bash_completion.d/docker
}

#*********************************
# Support Routines
#
__success() {
  printf " ${_xsLIGHTGREEN} 👌🏻  %s${_xsRESET}\n" "${1:?message argument is required}"
}

__fail() {
  printf " ${_xsLIGHTRED} ☠️  %s${_xsRESET}\n" "${1:?message argument is required}"
}

__info() {
  printf " ${_xsLIGHTYELLOW} 👉🏻  %s${_xsRESET}\n" "${1:?message argument is required}"
}


__view_header() {
  local item="${1}"
  printf '\n%s\n' "${SEPARATOR}"
  printf 'View: %s\n' "${item}"
}

__view_separator() {
  printf '\n%s\n' "${DIVIDER}"
}

__view_cmd() {
  local cmd="${1}"
  printf "${_xsLIGHTYELLOW}%s${_xsRESET}\n" "${cmd}"
}

__view_nodes() {
  __view_header "Nodes"
  __become
  __view_cmd 'docker node ls'
  docker node ls
}

__view_service() {
  __view_header "Services"
  __become
  __view_cmd 'docker service ls'
  docker service ls
}

__view_process() {
  __view_header "Processes"
  __become
  __view_cmd 'docker ps'
  docker ps
}

__view_all() {
  __view_separator
  __view_nodes
  __view_service
  __view_process
  __view_separator
}

__run_on_all() {
  local node
  local cmd="${@}"
  for node in ${NAMES[@]}; do
    __info "${node} -> ${cmd}"
    __become "${node}"
    eval "${cmd}"
  done
}

# __run_on=<node-name> command arguments
# sn --run-on=wrk02 image ls
# sn --run-on-wrk02 container ls
#
__run_on() {
  local cmd="${@}"
  __check_node_name "__run_on"
  __become "${NAMES[0]}"
  eval "${cmd}"
}

__run_for() {
  local cmd="${@}"

  [[ -z ${NODE_TYPE} ]] \
    && die "Node type is required: --run-for=worker <command arg1 arg2>" 9

  for name in "${NAMES[@]}"; do
    if [[ "${NODES[${name}]}" == "${NODE_TYPE}" ]]; then
      __become "${name}"
      eval "${cmd}"
    fi
  done
}
