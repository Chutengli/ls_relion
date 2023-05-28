# Use an official Ubuntu runtime as the base image
FROM ubuntu:20.04

# Avoid timezone interactive dialog
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    gcc-8 g++-8 \
    libopenmpi-dev \
    libfftw3-dev \
    libfltk1.3-dev \
    libtiff5-dev \
    libpng-dev \
    wget

# Set default shell to /bin/bash
SHELL ["/bin/bash", "-cu"]

COPY ./relion-4.0.1/ ./relion-4.0.1/

# Enter the relion directory
WORKDIR relion-4.0.1

# Configure
RUN mkdir build
WORKDIR build
RUN cmake ..

# Compile and install
RUN make -j2
RUN make install

# Run bash shell
CMD ["/bin/bash"]