FROM tensorflow/tensorflow:2.0.0-py3
MAINTAINER taekyoon <tgchoi03@gmail.com>

RUN apt-get update -y \
&& apt-get install -y wget language-pack-ko openjdk-8-jdk curl git-core locales

RUN apt-get install -y locales language-pack-ko
ENV LANG ko_KR.UTF-8
ENV LANGUAGE ko_KR:en
ENV LC_ALL ko_KR.UTF-8
RUN locale-gen ko_KR.UTF-8 \
&& update-locale LANG=ko_KR.UTF-8 \
&& dpkg-reconfigure locales

RUN apt install wget
RUN wget https://cmake.org/files/v3.14/cmake-3.14.3-Linux-x86_64.sh \
 && mkdir /opt/cmake \
 && sh cmake-3.14.3-Linux-x86_64.sh --prefix=/opt/cmake --skip-license \
 && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

RUN pip install --upgrade pip
RUN pip install konlpy cmake

# WORKDIR /workspace
# RUN wget https://raw.githubusercontent.com/konlpy/konlpy/master/scripts/mecab.sh \
# && bash mecab.sh
# RUN rm -rf /notebooks/*

# RUN pip install gensim soynlp soyspacing bokeh networkx selenium lxml pyldavis sentencepiece

RUN pip install jupyter pandas html5lib seaborn matplotlib nltk tqdm transformers mxnet gluonnlp sklearn 
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py
EXPOSE 8888

WORKDIR /workspace/practice
ENTRYPOINT jupyter notebook --allow-root --ip=0.0.0.0 --port=8888 --no-browser
