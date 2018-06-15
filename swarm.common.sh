#
#  Routines shared by swarm scripts
#
declare NODE_TYPE=''

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
  echo "become: ${node}"
  eval $(docker-machine env "${node}")
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
__view_nodes() {
  __become
  docker node ls
}

__view_service() {
  __become
  docker service ls
}

__view_process() {
  __become
  docker ps
}

__view_all() {
  __view_nodes
  __view_service
  __view_process
}

__run_on_all() {
  local node
  local cmd="${@}"
  for node in ${NAMES[@]}; do
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
