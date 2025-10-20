docker run -it --rm \
  --privileged \
  --net=host \
  --ipc=host \
  precision_landing \
ros2 run precision_landing landing_node