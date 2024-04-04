![[Pasted image 20240403004851.png]]
![[Pasted image 20240403004908.png]]
![[Pasted image 20240403004929.png]]
#### Logical Block:
- The smallest unit of transfer in a disk drive, typically 512 bytes in size (but can vary). 
- It serves as the basic unit for addressing and data transfer.
- Some disks can be **low-level formatted** to have a different logical block size, such as 1,024 byte.

#### Mapping Logical Blocks to Sectors:
- The logical blocks are mapped onto the physical sectors of the disk in a **one-dimensional array**. Sector 0 is the first sector of the first track on the outermost cylinder. 
- The mapping proceeds **sequentially** through each track of the cylinder, then through the rest of the tracks in that cylinder, and finally through the rest of the cylinders from outermost to innermost.

#### Addressing
- A **logical block number** can be converted into an **old-style disk address** consisting of a *cylinder number*, a *track number* within that cylinder, and a *sector number* within that track.

#### Difficulties in translation of logical block number into old style disk address
- Most disks have some defective sectors, but the mapping hides this by substituting spare sectors from elsewhere on the disk.
- The number of sectors per track is not a constant on some drives. These introduce further complexity in the mapping process.
	1. **Constant Linear Velocity (CLV)**:
		- *The density of bits per track is uniform*.
		- The farther a track is from the centre of the disk, the greater its length, so the more sectors it can hold.
		- Drive *increases its* *rotation speed* as the *head moves from the outer to the inner tracks* to keep the same rate of data moving under the head.
		- Used in CD-ROM, DVD-ROM.
	2. **Constant Angular Velocity**:
		- *The density of bits decreases from inner tracks to outer tracks.*
		- To keep the data rate constant he *disk rotation speed stays constant*.


