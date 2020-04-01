FROM ros:melodic-ros-base

ENV IM_IN_DOCKER Yes

RUN apt-get update --fix-missing && \
    apt-get install -y \
    python-pip

RUN apt-get install -y libzmq3-dev \
                       git \
                       build-essential \
                       autoconf \
                       libtool \
                       libeigen3-dev \
                       cmake \
                       vim

RUN cp -r /usr/include/eigen3/Eigen /usr/include

RUN git clone https://github.com/google/protobuf.git && \
    cd protobuf && \
    ./autogen.sh && \
    ./configure && \
    make -j8 && \
    make install && \
    ldconfig && \
    make clean && \
    cd .. && \
    rm -r protobuf

RUN pip install --upgrade pip

RUN pip install numpy==1.16.0 \
                scipy==1.2.0 \
                zmq \
                pyzmq \
                Pillow \
                gym \
                protobuf \
                pyyaml 


RUN git clone https://github.com/f1tenth/f1tenth_gym

RUn cd f1tenth_gym && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

RUN cd f1tenth_gym && \
    cp ./build/sim_requests_pb2.py ./gym/ && \
    pip install -e gym/

RUN /bin/bash -c "source /opt/ros/melodic/setup.bash; mkdir -p catkin_ws/src; cd catkin_ws; catkin_make"

RUN mkdir /catkin_ws/src/f1tenth_gym_ros

COPY . /catkin_ws/src/f1tenth_gym_ros

RUN /bin/bash -c "source /opt/ros/melodic/setup.bash; cd catkin_ws; catkin_make; source devel/setup.bash"


CMD ["/catkin_ws/src/f1tenth_gym_ros/start.sh"]

# CMD ["roslaunch", "package file.launch"]