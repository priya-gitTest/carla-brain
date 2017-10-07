# Udacity capstone project dockerfile
FROM ros:kinetic-robot
LABEL maintainer="olala7846@gmail.com"

# Install Dataspeed DBW https://goo.gl/KFSYi1 from binary
# adding Dataspeed server to apt
RUN sh -c 'echo "deb [ arch=amd64 ] http://packages.dataspeedinc.com/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-dataspeed-public.list' && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FF6D3CDA && \
    sh -c 'echo "yaml http://packages.dataspeedinc.com/ros/ros-public-'$ROS_DISTRO'.yaml '$ROS_DISTRO'" > /etc/ros/rosdep/sources.list.d/30-dataspeed-public-'$ROS_DISTRO'.list'
RUN rosdep update && \
    apt-get update && \
    apt-get install -y --no-install-recommends ros-$ROS_DISTRO-dbw-mkz \
                                               ros-$ROS_DISTRO-cv-bridge \
                                               ros-$ROS_DISTRO-pcl-ros \
                                               ros-$ROS_DISTRO-image-proc \
                                               netbase \
                                               python-pip \
                                               ccache && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /usr/lib/ccache/:$PATH

# install python packages
RUN pip install --no-cache-dir --upgrade "pip==9.0.1" && \
    pip install --no-cache-dir "Flask==0.12.2" "attrdict==2.0.0" "eventlet==0.21.0" "python-socketio==1.8.1" "numpy==1.13.3" "Pillow==4.3.0" "scipy==0.19.1" "keras==1.2.0" "tensorflow==1.0.0" && \
    mkdir -p /capstone && mkdir -p /root/.ccache

VOLUME ["/capstone"]
VOLUME ["/root/.ros/log/"]
VOLUME ["/root/.ccache"]
WORKDIR /capstone/ros
