FROM ubuntu:22.04
RUN apt update && apt install -y wget tar
RUN useradd -ms /bin/bash litecoin
USER litecoin
WORKDIR /home/litecoin
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
