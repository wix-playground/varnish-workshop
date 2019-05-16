#!/bin/bash
NEW_CONFIG_VERSION=$1

if [ -z "$NEW_CONFIG_VERSION" ]; then
    echo "Please enter new configuration name..."
    exit 1
fi

echo "Loading new VCL configuration version: ${NEW_CONFIG_VERSION}"
docker exec -it docker_varnish_1 varnishadm -T 127.0.0.1:6082 -S /etc/varnish/secret vcl.load $NEW_CONFIG_VERSION /etc/varnish/default.vcl
if [ $? -eq 0 ]; then
    echo "Activating new VCL configuration version: ${NEW_CONFIG_VERSION}"
    docker exec -it docker_varnish_1 varnishadm -T 127.0.0.1:6082 -S /etc/varnish/secret vcl.use $NEW_CONFIG_VERSION
fi
