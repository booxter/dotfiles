#!/bin/sh
set -e

REGISTRY=registry.stage.redhat.io
#SBOM_URL=https://atlas.devshift.net/sbom/content
SBOM_URL=https://atlas.build.devshift.net

if [ -z "$1" ]; then
	echo "Usage: $0 <image>"
	exit 1
fi

IMAGE=$1

# if no version in image name, add latest
if [[ ! $IMAGE =~ : ]]; then
	IMAGE="$IMAGE:latest"
fi

# if no organization in image name, add rhelai1
if [[ ! $IMAGE =~ / ]]; then
	IMAGE="rhelai1/$IMAGE"
fi

# try to log in just in case; if already logged in, it will do nothing
echo "Logging in to $REGISTRY..."
skopeo login ${REGISTRY}

echo "Getting SBOM for image $IMAGE..."
REGISTRY_PATH=docker://$REGISTRY/$IMAGE
SBOM=$(skopeo inspect --override-os linux --override-arch amd64 $REGISTRY_PATH --format '{{ .Digest }}')

if [ $? -ne 0 ]; then
	echo "Error: Failed to get SBOM for image $IMAGE"
	exit 1
fi

if [ -z "$SBOM" ]; then
	echo "Error: No SBOM found for image $IMAGE"
	exit 1
fi

echo "Image: $IMAGE"
echo "Path: $REGISTRY_PATH"
echo "SBOM: $SBOM"

echo "Now open $SBOM_URL in a browser and Search for $SBOM"
