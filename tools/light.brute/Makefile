CWD=$(shell pwd)
INAME=./lb
CNAME=lb

build:
	docker build \
		--no-cache \
		--tag ${INAME} .

run:
	docker run \
		--volume ${CWD}/../build/:/home/test/lb \
		--name ${CNAME} \
		--rm \
		-it \
		--entrypoint /bin/bash \
		${INAME}

purge:
	docker rmi ${INAME}

clean:
	docker stop ${CNAME}
	docker rm ${CNAME}
