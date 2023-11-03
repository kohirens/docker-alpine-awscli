#!/bin/sh

set -e

img_tag="${1}"
do_push="${2}"
dbg="${3}"

if [ -z "${img_tag}" ]; then
    echo "missing required first argument docker image tag"
    exit 1
fi

export ALPINE_VER=$(cat alpine-version.txt)
export GLIBC_VER=$(cat alpine-glibc-version.txt)
DH_IMG="${DH_IMG_REPO}:${img_tag}"
echo "building ${DH_IMG}"

docker build --rm --no-cache \
    -t "${DH_IMG}" \
    --build-arg ALPINE_VER --build-arg GLIBC_VER \
    .

echo ""
echo ""
export AWS_VER_INFO="$(docker run -t --rm "${DH_IMG}" --version)"
export AWS_VER="$(echo "${AWS_VER_INFO}" | sed -E "s|^aws-cli/([0-9.]+).*|\1|")"
echo "AWS_VER=${AWS_VER}"
docker tag "${DH_IMG}" "${DH_IMG_REPO}:${AWS_VER}"

if [ "${do_push}" = "-push" ]; then
    echo ""
    echo ""
    echo "${DH_PASS}" | docker login -u "${DH_USER}" --password-stdin
    echo "Pushing ${DH_IMG}:${AWS_VER}"
    docker push "${DH_IMG}:${AWS_VER}"
fi

echo ""
echo ""
docker run -it --rm --entrypoint=ls "${DH_IMG_REPO}:${AWS_VER}" -la /usr/glibc-compat
docker run -it --rm "${DH_IMG_REPO}:${AWS_VER}" --version

echo ""
echo ""

if [ -n "${dbg}" ]; then
    docker images
fi

echo "Cleanup ${DH_IMG} ${DH_IMG}:${AWS_VER}"
docker rmi "${DH_IMG}"
docker rmi "${DH_IMG_REPO}:${AWS_VER}"
