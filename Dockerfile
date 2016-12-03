FROM armv7/armhf-ubuntu:16.10
MAINTAINER snchan20@yahoo.com

# setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# install packages
RUN apt-get -qq update && \
    apt-get install -qy vim git \
                        python python-dev python-pip python-numpy \
                        python3 python3-dev python3-pip python3-numpy \
                        build-essential cmake pkg-config \
                        libtiff5-dev libjasper-dev libpng-dev \
                        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                        libxvidcore-dev libx264-dev \
                        libatlas-base-dev gfortran libeigen3-dev && \
    apt-get autoremove && apt-get clean && \
    rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*

# install opencv from git
RUN git clone -b 2.4 https://github.com/opencv/opencv.git && \
    cd opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr \
          -D ENABLE_NEON=ON \
          -D WITH_PTHREADS_PF=ON \
#          -D WITH_OPENMP=ON \
          -D WITH_EIGEN=ON \
          -D WITH_JPEG=OFF \
          -D BUILD_opencv_gpu=OFF \
          -D INSTALL_C_EXAMPLES=OFF \
	  -D INSTALL_PYTHON_EXAMPLES=OFF \
          .. && \
    make -j3 && make install && \
    cd / && rm -rf /workplace
