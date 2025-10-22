# ELEC3607 - AUP-ZU3 Project

This repository contains project files and resources for the **ELEC3607 Embedded Systems** course, using the **AUP-ZU3 Development Board**.



---

##  Per-Lab Dependency Summary

| Lab |  Required Libraries |
|------|--------------------|
| **Lab 1 – GPIO**  | `libgpiod-dev`, `libgpiod-tools` |
| **Lab 2 – Si5351**   | `i2c-tools`, `libi2c-dev` |
| **Lab 3 – Tayloe**  |`i2c-tools`, `libi2c-dev` |
| **Lab 4 – WSPR Decoder**  | `pulseaudio`, `libpulse-dev`, `pipewire`, `sox`, `pulseaudio-utils`, `libfftw3-dev` |
| **Lab 5 – PCB**  | None |
| **Lab 6 – WSPR Implementation** | `gcc` (included in `packagegroup-core-buildessential`), `make`, `gdb` |
| **Lab 7 – A64 Assembly** | `binutils`, `make`, `libc-dev`, `gdb` |

---

##  Recommended Common Base Packages

To ensure all labs build and run correctly, append the following to your root filesystem configuration:

```bash
IMAGE_INSTALL:append = " \
i2c-tools libi2c-dev \
libgpiod-dev libgpiod-tools \
pulseaudio libpulse-dev pipewire \
sox pulseaudio-utils libfftw3-dev \
binutils gdb make libc-dev \
packagegroup-core-buildessential \
"

