FROM dweinstein/androguard:latest
MAINTAINER dweinstein "dweinst@insitusec.com"

ADD https://github.com/dweinstein/analysis-runner/archive/master.zip /tmp/runner.zip
RUN unzip -j /tmp/runner.zip -d /opt/ && \
    rm -f /tmp/.zip

RUN mkdir -p /opt/runner
ADD ./androguard_manifest.py /opt/app/androguard_manifest.py
ADD ./runner.sh /opt/runner/runner.sh
RUN chmod +x /opt/runner/runner.sh
ENV TOOL ${PYTHON} ./androguard_manifest.py
ENV CONTENT_TYPE text/xml

WORKDIR /opt/app/
ENTRYPOINT ["/opt/runner/runner.sh", "${TOOL}"]
