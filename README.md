# Red Hat Enterprise Linux - Platform

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

---

## Deliverables

### RPM builds

* Update Host Storage Agent utilities.
* Migrate Debian-based packages to a build process that supports both Debian
  packages and RPM-based packages.
* Test the ability to install packages both to Ubuntu-based HostOS and Red Hat
  HostOS.
* Expedite delivery of user stories defined by the IBM storage product owner for
  the milestone commitments.
* Manage user story delivery through agile sprints, including planning,
  execution, demo, and reflection.

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

### Regression testing and break/fix support

* Virtual-machine-based or single/two-node-based validation of system
  functionality.
* End-to-end Create Virtual System Image validation.
* End-to-end regression test functionality for boot and secondary volumes, bring
  your own key (BYOK), and volume expansion.
* End-to-end regression test functionality for file, snapshots, and encrypted
  images.
* End-to-end security regression test with security policies in place with
  respect to SELinux.

---

## Team

Team member emails, Slack, etc. will be filled in.

* Jeff Marckel
* Robert Metcalf
* Scott Rooke
* Tim Barry

---

## Links

### Libvirt

* [Explanation of libvirt, KVM, and QEMU](https://serverfault.com/questions/208693/difference-between-kvm-and-qemu)
* [FAQs](https://wiki.libvirt.org/page/FAQ)
* [Libvirt main page](https://libvirt.org/index.html)
* [RPM deployment guidance](https://libvirt.org/kbase/rpm-deployment.html)
* [Security](https://libvirt.org/drvqemu.html) mentions AppArmor and SELinux
