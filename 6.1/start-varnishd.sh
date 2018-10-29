#!/bin/bash
set -e

exec bash -c \
	"exec varnishd -n /varnishfs -F \
	-a ${VARNISH_HOST}:${VARNISH_PORT} \
	-f ${VCL_CONFIG} \
	-s malloc,${VARNISH_MEMORY} \
	${VARNISHD_PARAMS}"
