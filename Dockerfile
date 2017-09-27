FROM alpine:3.6

ENV VEGETA_VERSION 6.3.0
ENV AWS_CLI_VERSION 1.11.131

COPY ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ADD https://github.com/tsenart/vegeta/releases/download/v${VEGETA_VERSION}/vegeta-v${VEGETA_VERSION}-linux-amd64.tar.gz /tmp/vegeta.tar.gz

RUN cd /bin \
&& tar -zxvf /tmp/vegeta.tar.gz \
&& chmod +x /bin/vegeta \
&& rm /tmp/vegeta.tar.gz \
&& apk --no-cache update \
&& apk --no-cache add python py-pip py-setuptools ca-certificates groff less \
&& pip --no-cache-dir install awscli==${AWS_CLI_VERSION} \
&& rm -rf /var/cache/apk/*

WORKDIR /data

CMD [ "/bin/vegeta", "-h" ]
