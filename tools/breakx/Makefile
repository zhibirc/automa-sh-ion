CWD=$(shell pwd)
INAME=lb
CNAME=lb

build:
	docker rm --force --volumes ${CNAME} 2>/dev/null; echo
	docker rmi ${INAME} 2>/dev/null; echo
	docker build --no-cache --tag ${INAME} .

run:
	docker run \
		--volume ${CWD}/../build/:/home/test/lb \
		--name ${CNAME} \
		--rm \
		-it \
		--entrypoint /bin/bash \
		${INAME}
