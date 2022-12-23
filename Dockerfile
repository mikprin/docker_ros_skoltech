FROM osrf/ros:melodic-desktop-full


# Install dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \
    sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
RUN apt-get install -y curl screen nano && \
    apt-get install neofetch && \
    apt install python3-pip -y && \
    apt-get update -y && \
    apt-get install -y ros-$ROS_DISTRO-rospy && \
    apt-get install -y ros-$ROS_DISTRO-trac-ik && \
    apt-get install -y ros-$ROS_DISTRO-moveit && \
    apt-get install -y ros-$ROS_DISTRO-realsense2-camera && \
    apt-get install -y ros-$ROS_DISTRO-moveit-visual-tools

RUN apt-get install -y ros-$ROS_DISTRO-catkin python-catkin-tools

# Python dependencies
RUN sudo apt-get -y install python-serial

# Create catkin workspace
RUN mkdir -p /catkin_ws/src

WORKDIR /catkin_ws

COPY src /catkin_ws/src/my_robot/scripts

COPY deploy.sh /catkin_ws/deploy.sh

# Important to run catkin init before catkin build
RUN catkin init

RUN cd /catkin_ws/src && \
    catkin_create_pkg my_robot std_msgs rospy roscpp

# Add ROS environment variables to .bashrc
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Build catkin workspace
RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && \
    catkin build && \
    source /catkin_ws/devel/setup.bash"

# Run deploy script
CMD ["./deploy.sh"]
# CMD [ "roscore" ]
