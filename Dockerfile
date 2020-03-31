FROM ruby:2.7.0

RUN apt-get update && apt-get upgrade -y
RUN apt-get install git -y

ENV RUBYOPT -EUTF-8
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV MECAB_PATH /usr/local/lib/libmecab.so

ARG mecab_filename="mecab-0.996.tar.gz"
ARG mecab_ipadic_filename="mecab-ipadic-2.7.0-20070801.tar.gz"

RUN wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE" -O $mecab_filename
RUN wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM" -O $mecab_ipadic_filename

RUN tar zxfv $mecab_filename && cd mecab-0.996 && \
    ./configure && make && make check && su -c "make install"
RUN tar zxfv $mecab_ipadic_filename && cd mecab-ipadic-2.7.0-20070801 && \
    ./configure --with-charset=utf8 && make && su -c "make install"

RUN git clone https://github.com/ayumitamai97/secret_dinner.git

WORKDIR secret_dinner/

RUN bundle

ENTRYPOINT ["ruby", "secret_dinner.rb"]

