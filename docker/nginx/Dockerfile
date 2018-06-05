#ARGS
ARG NGINX_TAG=${NGINX_TAG}

FROM nginx:${NGINX_TAG}

# Environment variables
ENV HOMEPATH /webapp

# Install modules
RUN apt-get update && apt-get install -y curl nano

WORKDIR $HOMEPATH
