# HostOS

[This page](https://confluence.swg.usma.ibm.com:8445/display/HCP/HostOS+Repositories+and+Artifacts)
was used as a starting point for the following information.

## Page Summary

This page provides information about the git repositories and generated
artifacts used by the HostOS CI/CD team

## Overview

* The HostOS CI/CD team is responsible for developing the tools necessary to
  boot, deploy and upgrade bare metal systems up to the 'platform' layer.
* The deploy tools are modular and reasonably general purpose with the intent
  that support can be extended to support any bare metal deployment.
* The high level CI/CD tooling architecture can be found here in the SRB git
  repo
* The HostOS specific architecture can be found here in the SRB git repo

## Repositories

* In general, each HostOS release bundle has three components, 'tools' needed
  for deploying, a 'payload' to be deployed, and these items are packaged into a
  container to make a 'release' bundle.
* HostOS git repositories use the following convention: 'tool' repositories are
  named `hostos-xxx-tools`, 'payload' repositories are named
  `hostos-xxx-payload`, and 'release' bundle repositories are named
  `hostos-xxx-release`.
* All HostOS repositories can be found in the cloudlab github organization.
* All generated HostOS artifacts are stored in IBM Artifactory.

| Repository                   | Description | Generate Artifact | Comments |
| ---------------------------- | ----------- | ----------------- | -------- |
| hostos-common-tools          | Common source code that may be shared by all tools.             | debian package (.deb) and docker image. | |
| hostos-boot-tools            | Source code for boot tools.                                     | debian package (.deb) and docker image. | |
| hostos-boot-payloads         | Payload deployed by boot tools. The boot kernel and image.      | tarball? | This will be how the canonical image files are packaged and stored in artifactory. |
| hostos-boot-release          | Generates the boot release bundle container image.              | docker image:  | This artifact, if tagged appropriately, can reproduce a deployment identically to a given release.
| hostos-upgrade-tools         | Source code for sw upgrade tools.                               | debian package (.deb) and docker image. | |
| hostos-upgrade-payloads      | Payloads deployed by sw upgrade tools.                          | tarball (.tgz) and yml for each sw set and for each hw arch. | |
| hostos-base-os-sw-release    | Generates the base-os-sw release bundle container image.        | docker image: | This artifact, if tagged appropriately, can reproduce a deployment identically to a given release. |
| hostos-base-net-sw-release   | Generates the base-net-sw release bundle container image.       | docker image: | This artifact, if tagged appropriately, can reproduce a deployment identically to a given release. |
| hostos-nextgen-os-sw-release | Generates the nextgen-os-sw release bundle container image.     | docker image: | This artifact, if tagged appropriately, can reproduce a deployment identically to a given release. |
| hostos-config-tools          | Source code for config tools.                                   | debian package (.deb) and docker image. | |
| hostos-config-payloads       | Payload deployed by config tools.                               | tarball (.tgz) and yml. | Currently common for all hw arch (all) |
| hostos-config-release        | Generates the config release bundle container image.            | docker image: | This artifact, if tagged appropriately, can reproduce a deployment identically to a given release.
| hostos-kernel-patch-tools    | Source code for kernel live patch tools.                        |
| hostos-kernel-patch-payloads | Payload deployed by kernel live patch tools.                    |
| hostos-kernel-patch-release  | Generates the kernel live patch release bundle container image. | docker image: | This artifact, if tagged appropriately, can reproduce a deployment identically to a given release. |
