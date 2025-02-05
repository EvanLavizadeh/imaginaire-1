FROM nvcr.io/nvidia/pytorch:21.05-py3

ENV DEBIAN_FRONTEND=noninteractive
ARG DEBIAN_FRONTEND=noninteractive

# Install basics
RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        tmux \
        wget \
        bzip2 \
        unzip \
        g++ \
        ca-certificates \
        ffmpeg \
        libx264-dev \
        imagemagick

RUN pip install scikit-image tqdm wget
RUN pip install Pillow==6.1
RUN pip install cython pyyaml lmdb scipy tensorboard
#RUN pip install cython lmdb scipy tensorboard
RUN pip install jupyterlab --upgrade
RUN pip install opencv-python opencv-contrib-python
RUN pip install open3d-python
RUN pip install albumentations requests
RUN pip install imageio-ffmpeg
RUN pip install av
RUN pip install cmake
RUN pip install pynvml
RUN pip install nvidia-ml-py3==7.352.0
RUN pip install face-alignment dlib
RUN pip install av

# Install correlation.
COPY imaginaire/third_party/correlation correlation
RUN cd correlation && rm -rf build dist *-info && python setup.py install
# Install channelnorm.
COPY imaginaire/third_party/channelnorm channelnorm
RUN cd channelnorm && rm -rf build dist *-info && python setup.py install
# Install resample2d.
COPY imaginaire/third_party/resample2d resample2d
RUN cd resample2d && rm -rf build dist *.egg-info && python setup.py install
CMD echo "This is a test." | wc -
