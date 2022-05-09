# Linux Tricks & Tips

## Emergency Boot & Bootloaders

### Grub2 Reinstall from CLI

Mount Root file system and chroot to it, them mount EFI partition
```
mount /dev/sdxn /mnt
for a in dev proc sys run dev/pts; do mount -o bind /${a} /mnt/${a}; done
chroot /mnt
mkfs.vfat -F32 /dev/sdxn
mount /dev/sdxn /boot/efi
vi /etc/fstab ???
grub-install --root-directory=/ /dev/sdxn
update-grub
update-initramfs -c -k all
umount /boot/efi
exit
for a in dev/pts proc sys run dev; do umount /mnt/${a}; done
reboot
```
If any disk was reformatted don't forget to update /etc/fstab

### Boot Directly into a shell (or other standalone program)

Add `init=/absolute/path/to/program` to the Kernel command line parameters


## Bash Profile & bashrc

### Timestamp & CWD prompt e.g. 16:28:32:~$

Replace PS1 in .bashrc with `PS1='\[\e[03;33m\]\t\[\e[00;01;37m\]:\[\e[34m\]\W\[\e[00m\]\$ '`



## Virtual Machines & Virt-Manager

### Manual Backup of virtual machine 

```
virsh dumpxml nameofvm >  nameofvm.xml
tar -SJpcf nameofvm.txz nameofvm*
```
J = xz, use j for bzip2 (faster but less compression)

### Manual Restore of virtual machine backup
```
tar -SJpxf nameofvm.txz 
virsh define --file nameofvm.xml
```


qemu-img convert -O qcow2 source.qcow2 shrunk.qcow2
qemu-img convert -c -O qcow2 source.qcow2 shrunk.qcow2
virt-sparsify


### System sound setting in settings messed up

Try running `pavucontrol` and setting it under playback

### Physical terminal commands
#### Configure console width and height
```
stty cols 132 rows 34
```


