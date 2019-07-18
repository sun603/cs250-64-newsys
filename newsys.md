# New system for pi with 64 bit armv8 assembly 

There are other systems specially for pi but not for general purpose. 

Ubuntu mate has a special version for pi. https://ubuntu-mate.org/raspberry-pi/

## model support 
ARMv8 version Support Pi 3 B and Pi 3 B+. No information about pi 4 on website. Do not support Pi 2. 

ARMv7 support Pi 2 B, 3 B, 3 B+. No information about pi 4 on website. 

## install

Download image from https://ubuntu-mate.org/download/. Use the image for pi in 64bit. Burn image to sd card, use disk writer below. If write is not allowed use SD card formatter. Power on, and setup system. During installation, they do not need to split disk, just set pc name, new admin user, and time zone. 

## Tools to use for burn image

#### disk writer
Details on using linux system on https://ubuntu-mate.org/raspberry-pi/. 
Mac use Etcher https://www.balena.io/etcher/ 
Windows use Disk Imager https://sourceforge.net/projects/win32diskimager/

#### format sd card
> some may see a permission deny for a physical lock on SD card (the bigger one). 

SD card formatter https://www.sdcard.org/downloads/formatter/


#### wifi pal3.0

https://www.reddit.com/r/Purdue/comments/9nuard/connecting_to_pal30_eduroam_on_linux/