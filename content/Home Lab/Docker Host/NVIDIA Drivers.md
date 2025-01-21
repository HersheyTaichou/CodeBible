---
title: Setup NVIDIA Drivers for Docker Containers
---

To use an NVIDIA GPU for hardware acceleration in a docker container, you will need to configure the host to use the NVIDIA GPU, then install a toolkit to integrated with Docker. 

The recommended driver is dependent on what graphics card you have in your system. To determine the recommended driver, install and run the `nvidia-driver-assistant` package.

Debian 12 example:

```shell
sudo apt install nvidia-driver-assistant
nvidia-driver-assistant
```

NVIDIA details this in their technical blog. The article can be found at [NVIDIA Transitions Fully Towards Open-Source GPU Kernel Modules | NVIDIA Technical Blog](https://developer.nvidia.com/blog/nvidia-transitions-fully-towards-open-source-gpu-kernel-modules/)

Here is the process for installing the drivers:

[NVIDIA Driver Installation Guide](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html)

Then you will want to install the NVIDIA container toolkit, the process is documented here:

[Installing the NVIDIA Container Toolkit — NVIDIA Container Toolkit 1.17.3 documentation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)