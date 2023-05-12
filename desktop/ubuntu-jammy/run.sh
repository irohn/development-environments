# Session settings
IMAGE_NAME=rdesktop
CONTAINER_NAME=rdesktop
CONTAINER_HOME=/config
PORT=3333
SHARED_MEM_SIZE="1gb"

# run main container
docker run -d \
    --rm \
    -it \
    --name=$CONTAINER_NAME \
    --hostname=$(hostname) \
    -p $PORT:3000 \
    --shm-size=$SHARED_MEM_SIZE `# Memory allocation (min 1gb)` \
    -v /var/run/docker.sock:/var/run/docker.sock `# Docker socket's volume` \
    --device /dev/dri:/dev/dri `# GPU acceleration` \
    -e TITLE=$(hostname) \
    -e HOST_USERNAME=$(whoami) \
    $IMAGE_NAME

# Execute steps post run
docker exec $CONTAINER_NAME /bin/cp /tmp/configuration/Catppuccin-Frappe.colorscheme $CONTAINER_HOME/.local/share/konsole/Catppuccin-Frappe.colorscheme
docker exec $CONTAINER_NAME /bin/cp /tmp/configuration/main.profile $CONTAINER_HOME/.local/share/konsole/main.profile