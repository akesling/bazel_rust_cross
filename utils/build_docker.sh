#!/usr/bin/env bash
set -e

_utils_dir="$(pwd)/$(dirname "$0")"
_repo_root="${_utils_dir}/.."

_component_name="bazel_rust_cross"

_build_staging_dir="${_repo_root}/build/docker/"
_dockerfile="${_repo_root}/Dockerfile"

_build_target="//${_component_name}:linux_tarball"
_build_flags="--compilation_mode=opt"

echo "Creating build staging directory ${_build_staging_dir}"
mkdir -p "${_build_staging_dir}"

echo "Building tarball"
# Build straight to print status / progress
bazel build  ${_build_flags} "${_build_target}"
# Run again to capture file name
_release_tarball="$(bazel build ${_build_flags} "${_build_target}" 2>&1 | grep "/tar.tar" | tr -d ' ')"

echo "Copying dependencies to build tree for use by docker"
rsync -a --delete "${_repo_root}/${_release_tarball}" "${_build_staging_dir}/${_component_name}.tar"

echo "Building docker container"
docker build -f "${_dockerfile}" "${_build_staging_dir}" \
    --build-arg "ARCHIVE_NAME=${_component_name}.tar" \
    --build-arg "ENTRYPOINT_NAME=${_component_name}" \
    -t "${_component_name}:latest"
