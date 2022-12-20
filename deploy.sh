#!/usr/bin/env bash

source /opt/ros/$ROS_DISTRO/setup.bash
source /catkin_ws/devel/setup.bash

roscore &

sleep 1s

rosrun my_robot talker.py &

sleep 1s

rosrun my_robot listener.py
