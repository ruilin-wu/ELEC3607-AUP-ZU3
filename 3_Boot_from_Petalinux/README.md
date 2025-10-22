---

## 8. Booting the Board

Insert the prepared micro-SD card into the AUP-ZU3 board.

1. Set the **boot mode switch** to **SD** (instead of JTAG).  
2. Power on the board.

The board should boot Linux automatically.

- **Login username:** `petalinux`  
- **Initial password:** will be requested and set on first login.

---

## 9. Important Boot Files

Only the following four files are essential for booting:

- `BOOT.BIN`
- `boot.scr`
- `image.ub`
- `rootfs.ext4`

These files are located in:

```
/home/aupzu3/aup-zu3-bsp/sw/zu3_linux_8GB/images/linux/
```

Copy these files to the SD card as described above to create a bootable system.

---