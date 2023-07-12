#DEBUG:blivet:action: [40] destroy format None on disk vda (id 4)
#DEBUG:blivet:action: [43] create format gpt disklabel on disk vda (id 4)
#DEBUG:blivet:action: [48] create device partition vda1 (id 45)
#DEBUG:blivet:action: [49] create format efi filesystem mounted at /boot/efi on partition vda1 (id 45)
#DEBUG:blivet:action: [55] create device partition vda2 (id 52)
#DEBUG:blivet:action: [56] create format ext4 filesystem mounted at /boot on partition vda2 (id 52)
#DEBUG:blivet:action: [62] create device partition vda3 (id 59)
#DEBUG:blivet:action: [63] create format ext4 filesystem mounted at / on partition vda3 (id 59)

#INFO:blivet:executing action: [40] destroy format None on disk vda (id 4)
#DEBUG:blivet:                DiskDevice.setup: vda ; orig: True ; status: True ; controllable: True ;
#DEBUG:blivet:                DeviceFormat.destroy: device: /dev/vda ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#INFO:blivet:executing action: [43] create format gpt disklabel on disk vda (id 4)
#DEBUG:blivet:                DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                DiskLabel.create: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  DiskLabel._create: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 0 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                DiskDevice.update_sysfs_path: vda ; status: True ;
#DEBUG:blivet:vda sysfs_path set to /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda
#INFO:blivet:executing action: [48] create device partition vda1 (id 45)
#DEBUG:blivet:                PartitionDevice.create: vda1 ; status: False ;
#DEBUG:blivet:                    PartitionDevice.setup_parents: name: vda1 ; orig: False ;
#DEBUG:blivet:                      DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      DiskLabel.setup: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  PartitionDevice._create: vda1 ; status: False ;
#DEBUG:blivet:                    PartitionDevice._wipe: vda1 ; status: False ;
#INFO:program:Running... dd if=/dev/zero of=/dev/vda bs=512 seek=2048 count=2048
#INFO:program:stderr:
#INFO:program:b'2048+0 records in'
#INFO:program:b'2048+0 records out'
#INFO:program:b'1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0361566 s, 29.0 MB/s'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 1 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:post-commit partition path is /dev/vda1
#DEBUG:blivet:                      PartitionDevice._set_parted_partition: vda1 ;
#DEBUG:blivet:device vda1 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7fef793200d0>  fileSystem: None
#  number: 1  path: /dev/vda1  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7fef79465e90>  PedPartition: <_ped.Partition object at 0x7fef7922b9c0>
#DEBUG:blivet:                    DeviceFormat.destroy: device: /dev/vda1 ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda1
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                      PartitionDevice.setup: vda1 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      PartitionDevice.update_sysfs_path: vda1 ; status: True ;
#DEBUG:blivet:vda1 sysfs_path set to /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda1
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                            PartitionDevice.read_current_size: exists: True ; path: /dev/vda1 ; sysfs_path: /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda1 ;
#DEBUG:testdata:sysfs attr /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda1/size: 313232383830300a
#DEBUG:blivet:updated vda1 size to 600 MiB (600 MiB)
#INFO:blivet:executing action: [49] create format efi filesystem mounted at /boot/efi on partition vda1 (id 45)
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 2 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 3 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 4 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 5 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 6 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 8 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 9 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 10 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 11 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 12 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 13 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 14 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 15 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 16 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 17 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 18 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 19 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 20 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 21 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 22 ;
#DEBUG:blivet:                PartitionDevice.set_flag: path: /dev/vda1 ; flag: 1 ;
#DEBUG:blivet:                DiskLabel.commit_to_disk: device: /dev/vda ; numparts: 1 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.setup: vda1 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                EFIFS.create: device: /dev/vda1 ; type: efi ; status: False ;
#DEBUG:blivet:                  EFIFS._create: type: vfat ; device: /dev/vda1 ; mountpoint: /boot/efi ;
#INFO:program:Running... mkdosfs /dev/vda1
#INFO:program:stdout:
#INFO:program:mkfs.fat 4.2 (2021-01-31)
#INFO:program:stderr:
#INFO:program:b'Cannot initialize conversion from codepage 850 to ANSI_X3.4-1968: Invalid argument'
#INFO:program:b'Cannot initialize conversion from ANSI_X3.4-1968 to codepage 850: Invalid argument'
#INFO:program:b'Using internal CP850 conversion table'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.update_sysfs_path: vda1 ; status: True ;
#DEBUG:blivet:vda1 sysfs_path set to /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda1
#INFO:blivet:executing action: [55] create device partition vda2 (id 52)
#DEBUG:blivet:                PartitionDevice.create: vda2 ; status: False ;
#DEBUG:blivet:                    PartitionDevice.setup_parents: name: vda2 ; orig: False ;
#DEBUG:blivet:                      DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      DiskLabel.setup: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  PartitionDevice._create: vda2 ; status: False ;
#DEBUG:blivet:                    PartitionDevice._wipe: vda2 ; status: False ;
#INFO:program:Running... dd if=/dev/zero of=/dev/vda bs=512 seek=1230848 count=2048
#INFO:program:stderr:
#INFO:program:b'2048+0 records in'
#INFO:program:b'2048+0 records out'
#INFO:program:b'1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.038125 s, 27.5 MB/s'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 2 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:post-commit partition path is /dev/vda2
#DEBUG:blivet:                      PartitionDevice._set_parted_partition: vda2 ;
#DEBUG:blivet:device vda2 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7fef793200d0>  fileSystem: None
#  number: 2  path: /dev/vda2  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7fef7937fcd0>  PedPartition: <_ped.Partition object at 0x7fef89d52d90>
#DEBUG:blivet:                    DeviceFormat.destroy: device: /dev/vda2 ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda2
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                      PartitionDevice.setup: vda2 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      PartitionDevice.update_sysfs_path: vda2 ; status: True ;
#DEBUG:blivet:vda2 sysfs_path set to /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda2
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                            PartitionDevice.read_current_size: exists: True ; path: /dev/vda2 ; sysfs_path: /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda2 ;
#DEBUG:testdata:sysfs attr /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda2/size: 323039373135320a
#DEBUG:blivet:updated vda2 size to 1024 MiB (1024 MiB)
#INFO:blivet:executing action: [56] create format ext4 filesystem mounted at /boot on partition vda2 (id 52)
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 1 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 2 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 3 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 4 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 5 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 6 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 8 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 9 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 10 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 11 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 12 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 13 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 14 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 15 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 16 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 17 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 18 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 19 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 20 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 21 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda2 ; flag: 22 ;
#DEBUG:blivet:                DiskLabel.commit_to_disk: device: /dev/vda ; numparts: 2 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.setup: vda2 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                Ext4FS.create: device: /dev/vda2 ; type: ext4 ; status: False ;
#DEBUG:blivet:                  Ext4FS._create: type: ext4 ; device: /dev/vda2 ; mountpoint: /boot ;
#INFO:program:Running... mke2fs -t ext4 /dev/vda2
#INFO:program:stdout:
#INFO:program:Discarding device blocks:      0/262144             done                            
#INFO:program:Creating filesystem with 262144 4k blocks and 65536 inodes
#INFO:program:Filesystem UUID: a498cce1-a66f-4fcd-b110-0cf30c8af4f9
#INFO:program:Superblock backups stored on blocks: 
#INFO:program:	32768, 98304, 163840, 229376
#INFO:program:
#INFO:program:Allocating group tables: 0/8   done                            
#INFO:program:Writing inode tables: 0/8   done                            
#INFO:program:Creating journal (8192 blocks): done
#INFO:program:Writing superblocks and filesystem accounting information: 0/8   done
#INFO:program:
#INFO:program:stderr:
#INFO:program:b'mke2fs 1.46.5 (30-Dec-2021)'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.update_sysfs_path: vda2 ; status: True ;
#DEBUG:blivet:vda2 sysfs_path set to /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda2
#INFO:blivet:executing action: [62] create device partition vda3 (id 59)
#DEBUG:blivet:                PartitionDevice.create: vda3 ; status: False ;
#DEBUG:blivet:                    PartitionDevice.setup_parents: name: vda3 ; orig: False ;
#DEBUG:blivet:                      DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      DiskLabel.setup: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  PartitionDevice._create: vda3 ; status: False ;
#DEBUG:blivet:                    PartitionDevice._wipe: vda3 ; status: False ;
#INFO:program:Running... dd if=/dev/zero of=/dev/vda bs=512 seek=3328000 count=2048
#INFO:program:stderr:
#INFO:program:b'2048+0 records in'
#INFO:program:b'2048+0 records out'
#INFO:program:b'1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0383048 s, 27.4 MB/s'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 3 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:post-commit partition path is /dev/vda3
#DEBUG:blivet:                      PartitionDevice._set_parted_partition: vda3 ;
#DEBUG:blivet:device vda3 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7fef793200d0>  fileSystem: None
#  number: 3  path: /dev/vda3  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7fef793e4990>  PedPartition: <_ped.Partition object at 0x7fef7922bbf0>
#DEBUG:blivet:                    DeviceFormat.destroy: device: /dev/vda3 ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda3
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                      PartitionDevice.setup: vda3 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      PartitionDevice.update_sysfs_path: vda3 ; status: True ;
#DEBUG:blivet:vda3 sysfs_path set to /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda3
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                            PartitionDevice.read_current_size: exists: True ; path: /dev/vda3 ; sysfs_path: /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda3 ;
#DEBUG:testdata:sysfs attr /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda3/size: 33383631323939320a
#DEBUG:blivet:updated vda3 size to 18.41 GiB (18.41 GiB)
#INFO:blivet:executing action: [63] create format ext4 filesystem mounted at / on partition vda3 (id 59)
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 1 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 2 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 3 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 4 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 5 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 6 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 8 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 9 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 10 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 11 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 12 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 13 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 14 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 15 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 16 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 17 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 18 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 19 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 20 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 21 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda3 ; flag: 22 ;
#DEBUG:blivet:                DiskLabel.commit_to_disk: device: /dev/vda ; numparts: 3 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.setup: vda3 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                Ext4FS.create: device: /dev/vda3 ; type: ext4 ; status: False ;
#DEBUG:blivet:                  Ext4FS._create: type: ext4 ; device: /dev/vda3 ; mountpoint: / ;
#INFO:program:Running... mke2fs -t ext4 /dev/vda3
#INFO:program:stdout:
#INFO:program:Discarding device blocks:       0/4826624               done                            
#INFO:program:Creating filesystem with 4826624 4k blocks and 1207680 inodes
#INFO:program:Filesystem UUID: 4aef30b8-e78e-4337-8711-f3a431a7fdbd
#INFO:program:Superblock backups stored on blocks: 
#INFO:program:	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
#INFO:program:	4096000
#INFO:program:
#INFO:program:Allocating group tables:   0/148       done                            
#INFO:program:Writing inode tables:   0/148       done                            
#INFO:program:Creating journal (32768 blocks): done
#INFO:program:Writing superblocks and filesystem accounting information:   0/148       done
#INFO:program:
#INFO:program:stderr:
#INFO:program:b'mke2fs 1.46.5 (30-Dec-2021)'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.update_sysfs_path: vda3 ; status: True ;
#DEBUG:blivet:vda3 sysfs_path set to /sys/devices/pci0000:00/0000:00:02.3/0000:04:00.0/virtio2/block/vda/vda3
#DEBUG:blivet:                  PartitionDevice._set_parted_partition: vda1 ;
#DEBUG:blivet:device vda1 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7fef793200d0>  fileSystem: <parted.filesystem.FileSystem object at 0x7fef79410490>
#  number: 1  path: /dev/vda1  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7fef794105d0>  PedPartition: <_ped.Partition object at 0x7fef7922a390>
#DEBUG:blivet:                  PartitionDevice._set_parted_partition: vda2 ;
#DEBUG:blivet:device vda2 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7fef793200d0>  fileSystem: <parted.filesystem.FileSystem object at 0x7fef794106d0>
#  number: 2  path: /dev/vda2  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7fef79413790>  PedPartition: <_ped.Partition object at 0x7fef792295d0>
#DEBUG:blivet:                  PartitionDevice._set_parted_partition: vda3 ;
#DEBUG:blivet:device vda3 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7fef793200d0>  fileSystem: <parted.filesystem.FileSystem object at 0x7fef794111d0>
#  number: 3  path: /dev/vda3  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7fef79411350>  PedPartition: <_ped.Partition object at 0x7fef792283b0>
#INFO:anaconda.modules.storage.installation:setting boot flag on vda1
#DEBUG:blivet:             PartitionDevice.set_flag: path: /dev/vda1 ; flag: 1 ;
#INFO:anaconda.modules.storage.installation:Setting label on existing 600 MiB partition vda1 (45) with existing efi filesystem mounted at /boot/efi to 'EFI System Partition'
#DEBUG:blivet:           DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:           DiskLabel.commit_to_disk: device: /dev/vda ; numparts: 3 ;
#DEBUG:blivet:                       EFIFS.supported: supported: True ;
#DEBUG:blivet:                     Ext4FS.supported: supported: True ;
#DEBUG:blivet:                     Ext4FS.supported: supported: True ;
#INFO:anaconda.threading:Thread Done: AnaTaskThread-CreateStorageLayoutTask-1 (140666517845696)

set -x

DISK=$1

wipefs -f -a ${DISK}
parted -s ${DISK} mktable gpt
parted -s ${DISK} mkpart primary ext4 0% 5%
parted -s ${DISK} mkpart primary ext4 5% 12%
parted -s ${DISK} mkpart primary ext4 12% 100%
parted -s ${DISK} set 1 boot on
parted -s ${DISK} set 1 esp on
mkdosfs ${DISK}1
mkfs.ext4 ${DISK}2
mkfs.ext4 ${DISK}3

lsblk
