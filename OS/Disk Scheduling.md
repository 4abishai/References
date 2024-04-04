![[Pasted image 20240403005329.png]]

- To use hardware efficiently, the operating system aims for **fast access time** and **large disk bandwidth**. 
	- **Access Time:** For magnetic disks, access time consists of **seek time** (moving the heads to the desired cylinder) and **rotational latency** (rotating the desired sector to the disk head). 
	- **Disk bandwidth**: It is the total bytes transferred divided by the total time from the first request to the completion of the last transfer.

- Efficient disk I/O request management can improve both access time and bandwidth. When a process needs I/O to or from the disk, it sends a request to the operating system specifying **whether it's input or output**, the **disk address** and **memory addresses**, and the **number of sectors** to transfer. 

- *If the disk and controller are available, the request is serviced immediately. Otherwise, it's added to the queue of pending requests*. In a multiprogramming system, the disk queue often has several pending requests. When one request is completed, the *OS chooses which pending request to service next* using a disk-scheduling algorithm.

![[Pasted image 20240403005421.png]]
## Disk Scheduling Algorithms

### FCFS
- FCFS (First-Come, First-Served) disk scheduling is a simple disk scheduling algorithm where the *requests are processed in the order they arrive* in the disk queue. When a request is completed, the next request in the queue is serviced.
- It ensures that each I/0 request is served and thus *avoids starvation*.
- Since requests are serviced in the order they arrive, it can lead to *longer seek times if there are requests far apart* on the disk. This is known as the "head-of-the-line" blocking problem.
![[Pasted image 20240403005602.png]]

![[Pasted image 20240401163323.png]]

**SEE COPY**
### SSTF (Shortest Seek Time First)
- Services all the requests close to the current head position before moving the head far away to service other requests.
- SSTF scheduling is essentially a form of shortest-job-first (SJF) scheduling; and like SJF scheduling, it may cause *starvation* of some requests.
- SSTF chooses the pending request closest to the current head position. *Overhead* is involved in SSTF.

![[Pasted image 20240401163818.png]]
- We can do better by moving the head from 53 to 37, even though the latter is not closest, and then to 14, before turning around to service 65, 67, 98, 122, 124, and 183. This strategy reduces the total head movement to 208 cylinders.

### SCAN
- The disk arm starts at one end of the disk and *moves toward the other end*, servicing requests as it reaches each cylinder, until it gets to the other end of the disk. At the other end, the direction of *head movement is reversed, and servicing continues*. The head continuously scans back and forth across the disk. 
- The SCAN algorithm is sometimes called the **elevator algorithm**, since the disk arm behaves just like an elevator in a building, first servicing all the requests going up and then reversing to service requests the other way.
- Can lead to starvation if a i/o request is made dynamically. 

![[Pasted image 20240401172553.png]]

### C-SCAN
- Like SCAN, C-SCAN moves the head from one end of the disk to the other, servicing requests along the way. When the head reaches the other end, however, it immediately returns to the beginning of the disk without servicing any requests on the return trip. 
- The C-SCAN scheduling algorithm essentially treats the cylinders as a circular list that wraps around from the final cylinder to the first one.
![[Pasted image 20240401174903.png]]

### C-LOOK
![[Pasted image 20240401181204.png]]
