FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg"
KERNEL_FEATURES:append = " bsp.cfg"

SRC_URI += "file://user_2024-11-08-16-07-00.cfg \
            file://user_2025-03-04-15-34-00.cfg \
            file://user_2025-10-27-02-31-00.cfg \
            file://user_2025-11-13-06-23-00.cfg \
            "

