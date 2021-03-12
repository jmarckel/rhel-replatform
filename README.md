# Red Hat Enterprise Linux - Platform

## Table of contents

1. [Overview](#overview)
2. [Deliverables](#deliverables)
   * [RPM builds](#rpm-builds), [System bring-up](#system-bring-up), [System testing](#system-testing), [Regression testing](#regression-testing)
3. [Resources](#resources)
4. [Team](#team)
5. [Links](#links)
   * [IBM Cloudlab](#ibm-cloudlab), [Libvirt](#libvirt), [Security](#security)

## Overview

The current IBM Cloud hypervisor is built on a customized variant of Ubuntu
18.04. This variant uses newer versions of QEMU/libvirt and has custom kernel
patches to support IBM Cloud.

However, because we are running Ubuntu, some Red Hat workloads are not certified
to run on the IBM Cloud. The most prominent example of this is OpenShift.

Given that IBM has purchased Red Hat, this project moves VPC Gen 2 off an Ubuntu
KVM solution and onto a Red Hat KVM hypervisor.

We anticipate using RHEL 8.4 with the Advanced Virtualization packages. This
allows IBM to certify key Red Hat workloads on our cloud and ensure that IBM's
VPC cloud is a prime destination for OpenShift.

This document is based on the
[SRB proposal 1752](https://github.ibm.com/cloudlab/srb/tree/adf5cb953945033bd93793573f4dfb1b421f6d7f/proposals/1752).

## Deliverables

### RPM builds

* Update host storage agent utilities.
* Migrate Debian-based packages to a build process that supports both Debian
  packages and RPM-based packages.
* Test the ability to install packages both to Ubuntu-based HostOS and Red Hat
  HostOS.
* Expedite delivery of user stories defined by the IBM storage product owner for
  the milestone commitments.
* Manage user story delivery through agile sprints, including planning,
  execution, demo, and reflection.
* See the [HostOS page](hostos/README.md)

### System bring-up

* Update and migrate AppArmor NextGen security rules to SELinux-based security
  rules.
* Conduct system bring-up.
* Validate system bring-up upon availability of all buyer-developed pillars.

### System testing

* Automated function test updates:
* Validate storage connectivity from Red Hat base HostOS to be on par with
  Ubuntu base HostOS, targeting existing virtual and physical NetAPP-based NFS
  servers.
* Create test scripts to run existing test suites and support validation of
  newer releases of Red Hat.
* Provide regression testing in support of the Storage Product RHEL development
  team.
* Live migration enablement: upon start of other buyer-developed pillars,
  provide storage service pillar for full system bring-up of Red Hat compute
  node in a NextGen cluster.
* Optimization and stability: provide storage service pillar for end-to-end
  testing of NextGen control plane in staging environment. Address and fix any
  issues within the Storage Service pillar that are found in end-to-end testing.

### Regression testing

* Virtual-machine-based or single/two-node-based validation of system
  functionality.
* End-to-end create virtual system image validation.
* End-to-end regression test functionality for boot and secondary volumes, bring
  your own key (BYOK), and volume expansion.
* End-to-end regression test functionality for file, snapshots, and encrypted
  images.
* End-to-end security regression test with security policies in place with
  respect to SELinux.

## Resources

The following resources need to be identified.

* Is there a HostOS team.
* Where are code and deployment repositories and who is a gatekeeper.
* What modifications IBM made to Ubuntu that needs to be conveyed to Red Hat
  regarding advanced virtualization packages.
* Who within Red Hat is going to coordinate the RHEL 8.4 base and the inclusion
  of advanced virtualization packages.
* Where is the CI/CD pipeline (Jenkins) that build the existing Ubuntu images.

## Team

Team member emails, Slack, etc. will be filled in.

* Jeff Marckel
* Robert Metcalf
* Russell Cattelan
* Scott Rooke
* Tim Barry

## Links

### IBM Cloudlab

The [cloudlab](https://github.ibm.com/cloudlab) repository is a high-level
organization for IBM's Cloud.

The cloudlab repository is for cloud functionality, not applications or
services. Some examples of apps/services are: KMS (Key Management Service), and
RIAS (Regional Infrastructure API Service) - those are in individual
repositories.

All cloud implementations, not just IBM, is off the charts when it comes to
scale, scope, and complexity. There are layers upon layers of hardware,
software, processes, and services. Add in hundreds of acronyms and pretty soon
you can't comprehend what's going on without a guide - cloudlab is your guide.

The following links decompose the IBM Cloud into manageable pieces that makes it
easier to comprehend.

This project (Ubuntu to Red Hat platform) is interested in the following areas
(these are major sections with numerous sub-sections):

* [SRB - Systems Review Board](https://github.ibm.com/cloudlab/srb)
  * The SRB is a hand-picked cross-functional group of senior engineers and
    architects who work with development teams to review under-development
    projects for consistency and architectural alignment across the VPC product,
    and any IaaS offerings that integrate closely with VPC.

* [HostOS - architecture](https://github.ibm.com/cloudlab/srb/tree/master/architecture/hostos)
  * The Host Operating System CI/CD mission is to build and maintain the
    bare-metal and virtualized Operating Environments that support the Genesis
    Program, which is the next generation of IBM's Cloud.

* [HostOS - repositories](https://github.ibm.com/cloudlab?q=hostos)
  * There are 18 HostOS repositories (19 results but 1 is archived) for building
    and maintaining IBM Cloud hosts.

* [IaaS internal documentation](https://pages.github.ibm.com/cloudlab/internal-docs/)
  * Internal documentation for the IaaS Platform Operations team. Content
    includes new feature descriptions, runbooks, and troubleshooting solutions
    for the IBM Cloud infrastructure.

* [NextGen environments](https://github.ibm.com/nextgen-environments)
  * This describes HostOS bundles for each environment (DAL, WDC, and mzones).
    This is *not* an inventory list (servers and IP addresses). See the
    following repository, *platform inventory*.

* [Platform inventory](https://github.ibm.com/cloudlab/platform-inventory)
  * Mzone and under-cloud yml files.

### Libvirt

* [Explanation of libvirt, KVM, and QEMU](https://serverfault.com/questions/208693/difference-between-kvm-and-qemu)
* [FAQs](https://wiki.libvirt.org/page/FAQ)
* [Libvirt main page](https://libvirt.org/index.html)
* [RPM deployment guidance](https://libvirt.org/kbase/rpm-deployment.html)
* [Security](https://libvirt.org/drvqemu.html) mentions AppArmor and SELinux

### Security

Ubuntu 18.04 (the existing IBM Cloud platform) uses AppArmor. Red Hat 8.x uses
SELinux.

* AppArmor
  * [Ubuntu overview](https://ubuntu.com/server/docs/security-apparmor)
  * [Ubuntu wiki](https://wiki.ubuntu.com/AppArmor)
  * [Profiles](https://ubuntu.com/tutorials/beginning-apparmor-profile-development#1-overview)

* SELinux
  * [Red Hat overview](https://www.redhat.com/en/topics/linux/what-is-selinux)
