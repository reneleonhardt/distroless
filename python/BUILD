load(":config.bzl", "PYTHON_ARCHITECTURES", "PYTHON_DISTROS", "PYTHON_MAJOR_VERSIONS")
load(":python.bzl", "python_image", "python_image_index")

package(default_visibility = ["//visibility:public"])

[
    python_image(
        arch = arch,
        distro = distro,
        major_version = major_version,
        packages = [],
    )
    for distro in PYTHON_DISTROS
    for major_version in PYTHON_MAJOR_VERSIONS
    for arch in PYTHON_ARCHITECTURES[distro][major_version]
]

[
    python_image_index(
        architectures = PYTHON_ARCHITECTURES[distro][major_version],
        distro = distro,
        major_version = major_version,
    )
    for distro in PYTHON_DISTROS
    for major_version in PYTHON_MAJOR_VERSIONS
]
