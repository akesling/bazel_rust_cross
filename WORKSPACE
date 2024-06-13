workspace(name = "bazel_rust_cross")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#################################################################################
## Cross-Compiling CC Toolchain #################################################
#################################################################################

http_archive(
    name = "musl_toolchains",
    sha256 = "a09786968191a455534fb9165ad7beb0e9acf7dac1919a52289b0f95dceafa58",
    url = "https://github.com/bazel-contrib/musl-toolchain/releases/download/v0.1.13/musl_toolchain-v0.1.13.tar.gz",
)

load("@musl_toolchains//:repositories.bzl", "load_musl_toolchains")

load_musl_toolchains()

load("@musl_toolchains//:toolchains.bzl", "register_musl_toolchains")

register_musl_toolchains()
