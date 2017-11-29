FROM python:3.6.3-stretch
MAINTAINER https://github.com/ymping/

ENV DEVPI_SERVER_VERSION=4.3.1 \
	DEVPI_WEB_VERSION=3.2.1 \
	DEVPI_CLIENT_VERSION=3.1.0 \
	DEVPI_PASSWORD=devpipass \
	MIRROR_URL=https://pypi.doubanio.com/simple/

RUN pip install \
	"devpi-client==${DEVPI_CLIENT_VERSION}" \
	"devpi-web==${DEVPI_WEB_VERSION}" \
	"devpi-server==${DEVPI_SERVER_VERSION}"

EXPOSE 3141
VOLUME /data

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["devpi"]