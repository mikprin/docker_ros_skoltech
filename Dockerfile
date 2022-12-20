FROM osrf/ros:melodic-desktop-full


# Install dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get update && \
    apt-get install -y ros-$ROS_DISTRO-trac-ik && \
    apt-get install -y ros-$ROS_DISTRO-moveit && \
    apt-get install -y ros-$ROS_DISTRO-realsense2-camera && \
    apt-get install -y ros-$ROS_DISTRO-moveit-visual-tools

# Create catkin workspace
RUN mkdir -p /catkin_ws/src

COPY src /app

WORKDIR /catkin_ws

RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && catkin_make"


CMD ["roscore"]