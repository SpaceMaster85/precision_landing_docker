#!/bin/bash
set -e

source /opt/ros/${ROS_DISTRO}/setup.bash
source /root/ros_ws/install/setup.bash

exec "$@"
