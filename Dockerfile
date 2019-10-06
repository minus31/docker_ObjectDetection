FROM ubuntu:latest

MAINTAINER your_name "email@gmail.com"

RUN apt-get update -y

RUN apt-get install -y python-pip python-dev build-essential

#RUN echo "alias python=python3" >> ~/.bashrc && source ~/.bashrc

RUN apt-get install -y python3-pip

RUN pip3 install tensorflow

RUN apt-get install -y protobuf-compiler python-pil python-lxml

# Cython
RUN pip3 install --user cython

# Contextlib2
RUN pip3 install --user contextlib2

# Jupyter
RUN pip3 install --user jupyter

# Matplotlib
RUN pip3 install --user matplotlib 

# Pandas: 
RUN pip3 install pandas

EXPOSE 8888

RUN apt-get install -y git

RUN git clone --quiet https://github.com/tensorflow/models.git 

WORKDIR /models/research/
RUN protoc object_detection/protos/*.proto --python_out=.

RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

RUN python3 setup.py build
RUN python3 setup.py install

RUN echo 'alias jupyter-notebook="~/.local/bin/jupyter-notebook --ip=0.0.0.0 --port=8888 --allow-root"' >> ~/.bashrc

RUN . ~/.bashrc 

ENTRYPOINT [ "/bin/bash" ]

