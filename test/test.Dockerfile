FROM ubuntu:hirsute-20210723
# DL3008: Pin versions in apt-get install
RUN apt-get update && apt-get install -y curl
# DL3059: Multiple RUN commands should be consolidated
RUN echo hello world
