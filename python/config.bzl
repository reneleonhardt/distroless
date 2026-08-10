"python configurations"

PYTHON_DISTROS = ["debian12", "debian13"]

# The image tag segment, e.g. python3.14-debian13 / python3.15rc1-debian13.
# Full CPython versions live in //private/extensions:python.bzl (python_versions repo).
PYTHON_MAJOR_VERSIONS = ["3.13", "3.14", "3.15rc1"]

PYTHON_ARCHITECTURES = {
    "debian12": {
        "3.13": ["amd64", "arm64", "s390x"],
        "3.14": ["amd64", "arm64", "s390x"],
        "3.15rc1": ["amd64", "arm64", "s390x"],
    },
    "debian13": {
        "3.13": ["amd64", "arm64", "s390x", "riscv64"],
        "3.14": ["amd64", "arm64", "s390x", "riscv64"],
        "3.15rc1": ["amd64", "arm64", "s390x", "riscv64"],
    },
}
