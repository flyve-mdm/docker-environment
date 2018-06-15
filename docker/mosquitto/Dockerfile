#ARGS
ARG MOSQUITTO_TAG=${MOSQUITTO_TAG}

FROM eclipse-mosquitto:${MOSQUITTO_TAG}

RUN apk update
RUN apk add openssl make git