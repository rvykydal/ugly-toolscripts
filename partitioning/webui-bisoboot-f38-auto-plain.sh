#DEBUG:blivet:action: [45] destroy format None on disk vda (id 14)
#DEBUG:blivet:action: [48] create format gpt disklabel on disk vda (id 14)
#DEBUG:blivet:action: [53] create device partition vda1 (id 50)
#DEBUG:blivet:action: [54] create format biosboot on partition vda1 (id 50)
#DEBUG:blivet:action: [60] create device partition vda2 (id 57)
#DEBUG:blivet:action: [61] create format ext4 filesystem mounted at /boot on partition vda2 (id 57)
#DEBUG:blivet:action: [67] create device partition vda3 (id 64)
#DEBUG:blivet:action: [68] create format ext4 filesystem mounted at / on partition vda3 (id 64)
#INFO:blivet:executing action: [45] destroy format None on disk vda (id 14)
#DEBUG:blivet:                DiskDevice.setup: vda ; orig: True ; status: True ; controllable: True ;
#DEBUG:blivet:                DeviceFormat.destroy: device: /dev/vda ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#INFO:blivet:executing action: [48] create format gpt disklabel on disk vda (id 14)
#DEBUG:blivet:                DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                DiskLabel.create: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  DiskLabel._create: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 0 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                DiskDevice.update_sysfs_path: vda ; status: True ;
#DEBUG:blivet:vda sysfs_path set to /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda
#INFO:blivet:executing action: [53] create device partition vda1 (id 50)
#DEBUG:blivet:                PartitionDevice.create: vda1 ; status: False ;
#DEBUG:blivet:                    PartitionDevice.setup_parents: name: vda1 ; orig: False ;
#DEBUG:blivet:                      DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      DiskLabel.setup: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  PartitionDevice._create: vda1 ; status: False ;
#DEBUG:blivet:                    PartitionDevice._wipe: vda1 ; status: False ;
#INFO:program:Running... dd if=/dev/zero of=/dev/vda bs=512 seek=2048 count=2047
#INFO:program:stderr:
#INFO:program:b'2047+0 records in'
#INFO:program:b'2047+0 records out'
#INFO:program:b'1048064 bytes (1.0 MB, 1.0 MiB) copied, 0.0314806 s, 33.3 MB/s'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 1 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:post-commit partition path is /dev/vda1
#DEBUG:blivet:                      PartitionDevice._set_parted_partition: vda1 ;
#DEBUG:blivet:device vda1 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7f5cc0e55a30>  fileSystem: None
#  number: 1  path: /dev/vda1  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7f5cc0e4ca40>  PedPartition: <_ped.Partition object at 0x7f5cc0d67d80>
#DEBUG:blivet:                    DeviceFormat.destroy: device: /dev/vda1 ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda1
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                      PartitionDevice.setup: vda1 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      PartitionDevice.update_sysfs_path: vda1 ; status: True ;
#DEBUG:blivet:vda1 sysfs_path set to /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda1
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                            PartitionDevice.read_current_size: exists: True ; path: /dev/vda1 ; sysfs_path: /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda1 ;
#DEBUG:testdata:sysfs attr /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda1/size: 323034380a
#DEBUG:blivet:updated vda1 size to 1024 KiB (1024 KiB)
#INFO:blivet:executing action: [54] create format biosboot on partition vda1 (id 50)
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 1 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 2 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 3 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 4 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 5 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 6 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 8 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 9 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 10 ;
#DEBUG:blivet:                PartitionDevice.unset_flag: path: /dev/vda1 ; flag: 11 ;
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
#DEBUG:blivet:                PartitionDevice.set_flag: path: /dev/vda1 ; flag: 12 ;
#DEBUG:blivet:                DiskLabel.commit_to_disk: device: /dev/vda ; numparts: 1 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.setup: vda1 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                BIOSBoot.create: device: /dev/vda1 ; type: biosboot ; status: False ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.update_sysfs_path: vda1 ; status: True ;
#DEBUG:blivet:vda1 sysfs_path set to /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda1
#INFO:blivet:executing action: [60] create device partition vda2 (id 57)
#DEBUG:blivet:                PartitionDevice.create: vda2 ; status: False ;
#DEBUG:blivet:                    PartitionDevice.setup_parents: name: vda2 ; orig: False ;
#DEBUG:blivet:                      DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      DiskLabel.setup: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  PartitionDevice._create: vda2 ; status: False ;
#DEBUG:blivet:                    PartitionDevice._wipe: vda2 ; status: False ;
#INFO:program:Running... dd if=/dev/zero of=/dev/vda bs=512 seek=4096 count=2048
#INFO:program:stderr:
#INFO:program:b'2048+0 records in'
#INFO:program:b'2048+0 records out'
#INFO:program:b'1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0443986 s, 23.6 MB/s'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 2 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:post-commit partition path is /dev/vda2
#DEBUG:blivet:                      PartitionDevice._set_parted_partition: vda2 ;
#DEBUG:blivet:device vda2 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7f5cc0e55a30>  fileSystem: None
#  number: 2  path: /dev/vda2  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7f5cc0e4ca70>  PedPartition: <_ped.Partition object at 0x7f5cc0d52980>
#DEBUG:blivet:                    DeviceFormat.destroy: device: /dev/vda2 ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda2
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                      PartitionDevice.setup: vda2 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      PartitionDevice.update_sysfs_path: vda2 ; status: True ;
#DEBUG:blivet:vda2 sysfs_path set to /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda2
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                            PartitionDevice.read_current_size: exists: True ; path: /dev/vda2 ; sysfs_path: /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda2 ;
#DEBUG:testdata:sysfs attr /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda2/size: 323039373135320a
#DEBUG:blivet:updated vda2 size to 1024 MiB (1024 MiB)
#INFO:blivet:executing action: [61] create format ext4 filesystem mounted at /boot on partition vda2 (id 57)
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
#INFO:program:Creating filesystem with 262144 4k blocks and 65536 inodes
#INFO:program:Filesystem UUID: 4f1abb6a-760c-4b52-a91a-de61fbe87c96
#INFO:program:Superblock backups stored on blocks: 
#INFO:program:	32768, 98304, 163840, 229376
#INFO:program:
#INFO:program:Allocating group tables: 0/8   done                            
#INFO:program:Writing inode tables: 0/8   done                            
#INFO:program:Creating journal (8192 blocks): done
#INFO:program:Writing superblocks and filesystem accounting information: 0/8   done
#INFO:program:
#INFO:program:stderr:
#INFO:program:b'mke2fs 1.47.0 (5-Feb-2023)'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.update_sysfs_path: vda2 ; status: True ;
#DEBUG:blivet:vda2 sysfs_path set to /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda2
#INFO:blivet:executing action: [67] create device partition vda3 (id 64)
#DEBUG:blivet:                PartitionDevice.create: vda3 ; status: False ;
#DEBUG:blivet:                    PartitionDevice.setup_parents: name: vda3 ; orig: False ;
#DEBUG:blivet:                      DiskDevice.setup: vda ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      DiskLabel.setup: device: /dev/vda ; type: disklabel ; status: False ;
#DEBUG:blivet:                  PartitionDevice._create: vda3 ; status: False ;
#DEBUG:blivet:                    PartitionDevice._wipe: vda3 ; status: False ;
#INFO:program:Running... dd if=/dev/zero of=/dev/vda bs=512 seek=2101248 count=2048
#INFO:program:stderr:
#INFO:program:b'2048+0 records in'
#INFO:program:b'2048+0 records out'
#INFO:program:b'1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0305702 s, 34.3 MB/s'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                    DiskLabel.commit: device: /dev/vda ; numparts: 3 ;
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:post-commit partition path is /dev/vda3
#DEBUG:blivet:                      PartitionDevice._set_parted_partition: vda3 ;
#DEBUG:blivet:device vda3 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7f5cc0e55a30>  fileSystem: None
#  number: 3  path: /dev/vda3  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7f5cc0e4c380>  PedPartition: <_ped.Partition object at 0x7f5cc0dafec0>
#DEBUG:blivet:                    DeviceFormat.destroy: device: /dev/vda3 ; type: None ; status: False ;
#INFO:program:Running... wipefs -f -a /dev/vda3
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                      PartitionDevice.setup: vda3 ; orig: False ; status: True ; controllable: True ;
#DEBUG:blivet:                      PartitionDevice.update_sysfs_path: vda3 ; status: True ;
#DEBUG:blivet:vda3 sysfs_path set to /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda3
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                            PartitionDevice.read_current_size: exists: True ; path: /dev/vda3 ; sysfs_path: /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda3 ;
#DEBUG:testdata:sysfs attr /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda3/size: 33393833393734340a
#DEBUG:blivet:updated vda3 size to 19 GiB (19 GiB)
#INFO:blivet:executing action: [68] create format ext4 filesystem mounted at / on partition vda3 (id 64)
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
#INFO:program:Creating filesystem with 4979968 4k blocks and 1245184 inodes
#INFO:program:Filesystem UUID: a2472b0b-724b-4ae9-a9e1-d6597957c34b
#INFO:program:Superblock backups stored on blocks: 
#INFO:program:	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
#INFO:program:	4096000
#INFO:program:
#INFO:program:Allocating group tables:   0/152       done                            
#INFO:program:Writing inode tables:   0/152       done                            
#INFO:program:Creating journal (32768 blocks): done
#INFO:program:Writing superblocks and filesystem accounting information:   0/152       done
#INFO:program:
#INFO:program:stderr:
#INFO:program:b'mke2fs 1.47.0 (5-Feb-2023)'
#DEBUG:program:Return code: 0
#INFO:program:Running... udevadm settle --timeout=300
#DEBUG:program:Return code: 0
#DEBUG:blivet:                PartitionDevice.update_sysfs_path: vda3 ; status: True ;
#DEBUG:blivet:vda3 sysfs_path set to /sys/devices/pci0000:00/0000:00:07.0/virtio1/block/vda/vda3
#DEBUG:blivet:                  PartitionDevice._set_parted_partition: vda1 ;
#DEBUG:blivet:device vda1 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7f5cc0e55a30>  fileSystem: None
#  number: 1  path: /dev/vda1  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7f5cc0da6870>  PedPartition: <_ped.Partition object at 0x7f5cc0d52ac0>
#DEBUG:blivet:                  PartitionDevice._set_parted_partition: vda2 ;
#DEBUG:blivet:device vda2 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7f5cc0e55a30>  fileSystem: <parted.filesystem.FileSystem object at 0x7f5cc0da6cc0>
#  number: 2  path: /dev/vda2  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7f5cc0da6ed0>  PedPartition: <_ped.Partition object at 0x7f5cc0dadb20>
#DEBUG:blivet:                  PartitionDevice._set_parted_partition: vda3 ;
#DEBUG:blivet:device vda3 new parted_partition parted.Partition instance --
#  disk: <parted.disk.Disk object at 0x7f5cc0e55a30>  fileSystem: <parted.filesystem.FileSystem object at 0x7f5cc0da6e40>
#  number: 3  path: /dev/vda3  type: 0
#  name:   active: True  busy: False
#  geometry: <parted.geometry.Geometry object at 0x7f5cc0da6d80>  PedPartition: <_ped.Partition object at 0x7f5cc0daddf0>
#INFO:anaconda.modules.storage.installation:Skipping vda2
#DEBUG:blivet:                  Iso9660FS.supported: supported: True ;
#DEBUG:blivet:                    Ext4FS.supported: supported: True ;
#DEBUG:blivet:                    Ext4FS.supported: supported: True ;
#INFO:anaconda.core.threads:Thread Done: AnaTaskThread-CreateStorageLayoutTask-1 (140036360238784)

set -x

DISK=$1

wipefs -f -a ${DISK}
parted -s ${DISK} mktable gpt
parted -s ${DISK} mkpart primary ext4 0% 5%
parted -s ${DISK} mkpart primary ext4 5% 12%
parted -s ${DISK} mkpart primary ext4 12% 100%
parted -s ${DISK} set 1 bios_grub on
mkfs.ext4 ${DISK}2
mkfs.ext4 ${DISK}3

lsblk
