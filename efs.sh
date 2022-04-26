# Make sure all packages are up-to-date
apt-get update -y
# Make sure that NFS utilities and AWS CLI utilities are available
apt-get install -y jq nfs-common nfs-utils python27 python27-pip awscli
pip install --upgrade awscli

# Name of the EFS filesystem (match what was created in EFS)
EFS_FILE_SYSTEM_NAME="my-efs-filesystem"

# Gets the EC2 availability zone for the current ECS instance
EC2_AVAIL_ZONE="$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)"
# Gets the EC2 region for the current ECS instance
EC2_REGION="$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')"

# Creates the mount-point for the EFS filesystem
DIR_TGT="/mnt/efs"
mkdir "${DIR_TGT}"

# Get the EFS filesystem ID.
EFS_FILE_SYSTEM_ID="$(/usr/local/bin/aws efs describe-file-systems --region "${EC2_REGION}" | jq '.FileSystems[]' | jq "select(.Name==\"${EFS_FILE_SYSTEM_NAME}\")" | jq -r '.FileSystemId')"

if [ -z "${EFS_FILE_SYSTEM_ID}" ]; then
    echo "ERROR: variable not set" 1> /etc/efssetup.log
    exit
fi

# Create the mount source path
DIR_SRC="${EC2_AVAIL_ZONE}.${EFS_FILE_SYSTEM_ID}.efs.${EC2_REGION}.amazonaws.com"

# Mount the EFS filesystem
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,soft,timeo=600,retrans=2 "${DIR_SRC}:/" "${DIR_TGT}"

# Backup of the existing /etc/fstab
cp -p "/etc/fstab" "/etc/fstab.back-$(date +%F)"

# Add the new mount point to /etc/fstab
echo -e "${DIR_SRC}:/ \t\t ${DIR_TGT} \t\t nfs \t\t nfsvers=4.1,rsize=1048576,wsize=1048576,soft,timeo=600,retrans=2 \t\t 0 \t\t 0" | tee -a /etc/fstab

# Stop the ECS agent container
#docker stop ecs-agent

# Restart Docker
/etc/init.d/docker restart

# Start the ECS agent container
#docker start ecs-agent
