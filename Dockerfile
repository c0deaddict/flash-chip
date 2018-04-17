FROM ubuntu:14.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y \
        build-essential \
        git \
        mercurial \
        cmake \
        curl \
        screen \
        unzip \
        device-tree-compiler \
        libncurses-dev \
        ppp \
        cu \
        linux-image-extra-virtual \
        u-boot-tools \
        android-tools-fastboot \
        android-tools-fsutils \
        python-dev \
        python-pip \
        libusb-1.0-0-dev \
        g++-arm-linux-gnueabihf \
        pkg-config \
        libacl1-dev \
        zlib1g-dev \
        liblzo2-dev \
        uuid-dev \
        libc6-i386 \
        lib32stdc++6 \
        lib32z1

# Installing sunxi-tools
RUN git clone http://github.com/linux-sunxi/sunxi-tools && \
    cd sunxi-tools && \
    make && \
    make misc && \
    mv $PWD/sunxi-bootinfo /usr/local/bin/ && \
    mv $PWD/sunxi-fel  /usr/local/bin/ && \
    mv $PWD/sunxi-fexc /usr/local/bin/ && \
    mv $PWD/sunxi-nand-part /usr/local/bin/ && \
    mv $PWD/sunxi-pio /usr/local/bin/ && \
    mv $PWD/phoenix_info /usr/local/bin/ && \
    mv $PWD/sunxi-nand-image-builder /usr/local/bin/ && \
    cd ..

RUN git clone http://github.com/nextthingco/chip-mtd-utils && \
    cd chip-mtd-utils && \
    git checkout by/1.5.2/next-mlc-debian && \
    make && \
    make install && \
    cd ..

# Installing CHIP-tools
RUN git clone https://github.com/NextThingCo/CHIP-tools.git && \
    git clone http://github.com/NextThingCo/CHIP-buildroot

RUN apt-get install -y wget
WORKDIR CHIP-tools
