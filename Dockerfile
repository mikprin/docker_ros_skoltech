FROM osrf/ros:melodic-desktop-full

# Add DNS server

# Install dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \
    sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
RUN apt-get install -y curl screen nano && \
    apt install python3-pip -y && \
    apt-get update -y && \
    apt-get install -y ros-$ROS_DISTRO-rospy && \
    apt-get install -y ros-$ROS_DISTRO-trac-ik && \
    apt-get install -y ros-$ROS_DISTRO-moveit && \
    apt-get install -y ros-$ROS_DISTRO-realsense2-camera && \
    apt-get install -y ros-$ROS_DISTRO-moveit-visual-tools

RUN apt-get install -y ros-$ROS_DISTRO-catkin python-catkin-tools

# Python dependencies
RUN sudo apt-get install python-serial
# RUN /usr/bin/python3 -m pip3 install pyserial
# RUN pip3 install pyserial

# Create catkin workspace
RUN mkdir -p /catkin_ws/src

WORKDIR /catkin_ws

COPY src /catkin_ws/src/my_robot/scripts

COPY deploy.sh /catkin_ws/deploy.sh

RUN catkin init

RUN cd /catkin_ws/src && \
    catkin_create_pkg my_robot std_msgs rospy roscpp

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && \
    catkin build && \
    source /catkin_ws/devel/setup.bash"

CMD ["./deploy.sh"]
# CMD [ "roscore" ]
