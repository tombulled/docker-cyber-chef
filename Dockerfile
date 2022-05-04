FROM alpine:3 as intermediate

LABEL stage=intermediate

RUN apk add --update git
RUN git clone --depth 1 --branch v9.37.3 https://github.com/gchq/CyberChef.git

FROM node:17

COPY --from=intermediate /CyberChef /CyberChef

WORKDIR /CyberChef

RUN npm install -g grunt-cli
RUN npm install -g http-server
RUN npm install
RUN grunt prod

ENTRYPOINT ["http-server", "build/prod"]