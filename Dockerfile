# Start with NVidia CUDA base image
FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Yeseong Kim <yek048@ucsd.edu>

# Install dependent packages
RUN apt-get -y update && apt-get install -y wget nano python-pip libboost-all-dev python-numpy build-essential python-dev python-setuptools libboost-python-dev libboost-thread-dev

# Compile and install pyCUDA from source
COPY python-pycuda/pycuda-2016.1.2.tar.gz /root/pycuda-2016.1.2.tar.gz
RUN tar xzf /root/pycuda-2016.1.2.tar.gz -C /root && cd /root/pycuda-2016.1.2 && ./configure.py --cuda-root=/usr/local/cuda --cudadrv-lib-dir=/usr/lib/x86_64-linux-gnu --boost-inc-dir=/usr/include --boost-lib-dir=/usr/lib --boost-python-libname=boost_python --boost-thread-libname=boost_thread --no-use-shipped-boost && make -j8 /root/pycuda-2016.1.2 && python setup.py install && pip install . && rm /root/pycuda* -rf

# Install useful python libraries and tools
RUN pip install pandas matplotlib sklearn scipy
RUN apt-get install -y vim python-tk

CMD nvidia-smi -q
