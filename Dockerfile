# Using Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Metadata to indicate that this image is for CT-ICP
LABEL description="Ubuntu 18.04 with GCC >= 7.5 and CMake >= 3.14 for CT-ICP"
LABEL version="1.0"
LABEL application="CT-ICP"

# Avoids prompts and messages from apt during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools and the desired GCC and CMake versions
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && apt-get update \
    && apt-get install -y \
        gcc-7 \
        g++-7 \
        wget \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 100

# Installing CMake 3.14
RUN wget -qO- "https://github.com/Kitware/CMake/releases/download/v3.14.0/cmake-3.14.0-Linux-x86_64.tar.gz" \
    | tar --strip-components=1 -xz -C /usr/local

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the default command
CMD ["/bin/bash"]
