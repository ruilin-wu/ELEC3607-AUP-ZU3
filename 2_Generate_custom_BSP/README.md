# Generate custom BSP (ELEC3607)

## Pre-bulit our petalinux project via our sxa file
We now have iic-8GB.xsa from vivado and petalinux-8GB.bsp from the official website. Our next step is to build two petalinux projects and compare the differences between the two and modify our custom iic-8GB.xsa to perfectly match the official petalinux-8GB.bsp.
### Custom xsa
First we create a petalinux project via our xsa:
```
petalinux-create project --template zynqMP --name iic-8GB-1026-1802
cd iic-8GB-1026-1802
petalinux-config --get-hw-description=/your_path/iic-8GB.xsa
```
Select Exit since we don't know the differences yet.

You can also generate a device tree:
```
petalinux-config -c device-tree
```
### Official BSP
Then we create a petalinux project via official petalinux-8GB.bsp:
```
cd ..
petalinux-create project -n original-1026-1826 -s petalinux-8GB.bsp
cd original-1026-1826
petalinux-config
```
Select Exit since we don't know the differences yet.

### Compare and get difference

We attach a **compare.sh** to compare every difference of these two project:
```
cd ..
bash compare.sh original-1026-1826 iic-8GB-1026-1802
```









petalinux-package bsp -p ./iic-8GB-1026-1802 --output MY.BSP

---

## PetaLinux Download
Download the latest PetaLinux tools (version **2024.1** ) from [AMD’s official website](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools/2024-1.html)

