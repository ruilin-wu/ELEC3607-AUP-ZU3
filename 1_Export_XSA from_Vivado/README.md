# Export XSA from Vivado for AUP-ZU3 (ELEC3607)

This document provides step-by-step instructions to build a XSA file for the **AUP-ZU3** development board used in the **ELEC3607 Embedded Systems Design** course.

---

## Vitis Download
Download the latest Vitis tools (version **2024.1** ) from [AMD’s official website](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis/2024-1.html)

---

## AUP-ZU3-BSP Download
Download the BSP tools of AUP-ZU3 from [RealDigital github website](https://github.com/RealDigitalOrg/aup-zu3-bsp)

---

## Requirements
- **Vivado 2024.1**
- Linux host system (e.g. Ubuntu 22.04.3)

---

## Build Steps

### 1. Create a Vivado Project
First Using "git clone", install "https://github.com/Digilent/vivado-library.git" repository in "~/Src"

To create a new vivado project from the tcl file:

```bash
cd ~/aup-zu3-bsp/hw
vivado -mode batch -source hw-8GB.tcl
vivado hw/hw.xpr
```

### 2. Add a IIC interface for RPI pin



**Key output:**
```
[INFO] Create project: zu3_linux
[INFO] New project successfully created in /home/aupzu3/aup-zu3-bsp/sw/zu3_linux
```

**Custom settings:**
```bash
cd zu3_linux
petalinux-config -c rootfs
```
1.Go to **Filesystems Packages-console-network-openssh**

Select 
![8](./image/8.png)

2.Go to **Filesystems Packages-base-i2c-tools**

Select 
![2](./image/2.png)

3.Go to **Filesystems Packages-libs-libgpiod**

Select 
![3](./image/3.png)

4.Go to **Filesystems Packages-misc-packagegroup-core-buildessential**

Select 
![5](./image/5.png)

5.Add 
```
CONFIG_libfftwf
CONFIG_sox
CONFIG_libgpiod-tools
```
to **project-spec/meta-user/conf/user-rootfsconfig**

Then go to User packages
Select 
![6](./image/6.png)

---

### 2. Build the Project

After creating the project, navigate into the project directory and build it:

```bash

petalinux-build
```

**Key output:**
```
[INFO] Building project
[INFO] Getting Platform info from HW file
[INFO] Generating Kconfig for project
[INFO] bitbake petalinux-image-minimal
NOTE: Tasks Summary: All succeeded.
[INFO] Successfully built project
```

---

### 3. Generate BOOT.BIN

Once the build completes, generate the boot image with:

```bash
petalinux-package boot --u-boot --fpga --force
```

**Key output:**
```
[INFO] File in BOOT BIN: zynqmp_fsbl.elf
[INFO] File in BOOT BIN: pmufw.elf
[INFO] File in BOOT BIN: hw_8GB.bit
[INFO] File in BOOT BIN: bl31.elf
[INFO] File in BOOT BIN: system.dtb
[INFO] File in BOOT BIN: u-boot.elf
[INFO] Generating zynqmp binary package BOOT.BIN...
[INFO] Binary is ready.
[INFO] Successfully Generated BIN File
```

The generated files will be located in:

```
aup-zu3-bsp/sw/zu3_linux/images/linux/
```

---

##  Output Files

Only the following four files are required for booting the AUP-ZU3 board:

| File | Description |
|------|--------------|
| `BOOT.BIN` | Boot image containing FSBL, PMUFW, bitstream, ATF, DTB, and U-Boot |
| `boot.scr` | U-Boot boot script |
| `image.ub` | Combined Linux kernel and device tree |
| `rootfs.ext4` | Root filesystem image |

Below is an example of output files :
![PetaLinux Build Overview](./image/1.png)

---

