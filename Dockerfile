FROM python:3

# docker build -t perfetto .

RUN git clone https://github.com/google/perfetto /opt/perfetto
WORKDIR /opt/perfetto

RUN tools/install-build-deps --ui
RUN tools/gn gen out/debug --args='is_debug=true'
RUN tools/ninja -C out/debug ui
RUN ui/build
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["./ui/run-dev-server", "--serve-host", "0.0.0.0"]
