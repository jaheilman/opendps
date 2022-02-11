
#docker build -t gcc-arm-none-eabi  .
#docker build -t gcc-arm-none-eabi --build-arg BUILD_USER=$USER .
#docker run --rm -ti --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd):/root gcc-arm-none-eabi bash


FROM ubuntu:20.04

ARG ARM_TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2"
# ARG BUILD_USER=10000

#USER root
RUN set -ex; \
        apt-get update; \
        apt-get install -y wget; \
        wget -O /tmp/gcc-arm-none-eabi.tar.bz2 "$ARM_TOOLCHAIN_URL"; \
        mkdir /opt/gcc-arm-none-eabi; \
        tar -xjvf /tmp/gcc-arm-none-eabi.tar.bz2 -C /opt/gcc-arm-none-eabi --strip-components 1; \
        rm /tmp/gcc-arm-none-eabi.tar.bz2;

# add the tools to the path
ENV PATH="/opt/gcc-arm-none-eabi/bin:${PATH}"

RUN set -ex; \
        apt-get update; \
        apt-get install -y git openocd make python netcat; \
	apt-get clean; \
        rm -rf /var/lib/apt/lists/*; 
        # adduser $BUILD_USER

# USER $BUILD_USER