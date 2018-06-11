#ARGS
ARG APACHE_TAG=${APACHE_TAG}

FROM httpd:${APACHE_TAG}

# Environment variables
ENV HOMEPATH /webapp

# Install modules
RUN apt-get update && apt-get install -y curl nano

WORKDIR $HOMEPATH
