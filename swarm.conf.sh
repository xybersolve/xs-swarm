#
#  Configuration for swarm scripts
#
# node definitions
#declare MACHINE_CONFIG_FILE=${SCRIPT_DIR}/swarm.vbx.conf.sh
#export MACHINE_CONFIG_FILE=${SCRIPT_DIR}/swarm.aws.conf.sh
#source "${MACHINE_CONFIG_FILE}" \
#  && echo "Loaded machine config file: ${MACHINE_CONFIG_FILE}" \
#  || die "Unable to load config file: ${MACHINE_CONFIG_FILE}" 1
#declare MACHINE_TYPE_TO_USE='aws'
declare MACHINE_TYPE_TO_USE='vbx'
