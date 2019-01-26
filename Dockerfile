# Start with NVidia CUDA base image
FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Yeseong Kim <yek048@ucsd.edu>

# Install dependent packages
RUN apt-get -y update && apt-get install -y wget nano python-pip libboost-all-dev python-numpy build-essential python-dev python-setuptools libboost-python-dev libboost-thread-dev

# Install pycuda
RUN pip install pycuda

# Install useful python libraries and tools
RUN pip install pandas matplotlib sklearn scipy sympy codegen pyimage pydot
RUN apt-get install -y vim python-tk graphviz sudo
RUN apt-get install -y git

CMD nvidia-smi -q
