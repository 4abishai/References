Thrashing occurs when a *system is excessively busy swapping pages in and out of memory* causing a significant *decrease in performance*.

1. **Minimum Number of Frames**: Each process requires a minimum number of frames (memory blocks) to execute efficiently. *If a low-priority process doesn't have enough frames, it will be suspended, and its remaining pages will be paged out (*moved to disk).

2. **Swap-In, Swap-Out Scheduling**: When a process is suspended due to insufficient frames, it introduces a swap-in, swap-out level of intermediate CPU scheduling. It *cannot keep all the actively used pages in memory*, leading to constant swapping of pages between memory and disk.

3. **Paging Faults**: Consequently, it quickly faults again, and again, and again, replacing pages that it must bring back in immediately (paging fault occurs when the operating system needs to bring a page into memory because it's not currently present).

4. **Thrashing**: If a process is constantly paging and replacing pages that it immediately needs again (*cannot keep all the actively used pages in memory*), it enters a state of thrashing. Thrashing is characterized by *high paging activity*, where the system spends more time moving pages between memory and disk than actually executing processes.

5. **Impact on Performance**: Thrashing significantly degrades system performance because the CPU spends more time managing memory (paging) than executing processes. It can lead to a noticeable slowdown in overall system responsiveness.

To prevent thrashing, the operating system needs to allocate a sufficient number of frames to each process, ensuring that they have enough memory to support their active pages without excessive swapping.

### Scenario

A scenario where thrashing can occur in a paging system due to the interaction between CPU utilization, degree of multiprogramming, and the global page-replacement algorithm.

1. **Monitoring CPU Utilization**: The operating system monitors CPU utilization and adjusts the degree of multiprogramming (number of processes in memory) based on the current utilization level. *If CPU utilization is low, the system tries to increase the degree of multiprogramming by introducing a new process.*

2. **Global Page-Replacement Algorithm**: The system uses a global page-replacement algorithm that *replaces pages without considering which process they belong to*. This means that any process's page can be replaced, leading to potential thrashing.

3. **Process Needs More Frames**: A process enters a new phase in its execution and requires more frames (memory blocks). As a result, it starts faulting (demanding pages from disk), which takes frames away from other processes.

4. **Chain Reaction**: The processes whose frames are taken away also start faulting, taking frames from other processes, and so on. This creates a chain reaction where multiple processes are constantly swapping pages in and out, leading to a high paging activity known as thrashing.

5. **Impact on CPU Utilization**: As processes queue up for the paging device, the ready queue for CPU execution empties, and CPU utilization decreases. The CPU scheduler interprets this as low CPU utilization and increases the degree of multiprogramming by introducing more processes.

6. **Worsening of Thrashing**: The new processes introduced try to get started by *taking frames from running processes, causing more page faults* and a longer queue for the paging device. This worsens the thrashing situation, leading to a further drop in CPU utilization.

7. **Cycle of Increasing and Decreasing Multiprogramming**: This cycle continues, with the *CPU scheduler trying to increase the degree of multiprogramming to improve CPU utilization, but instead, it exacerbates thrashing*. Eventually, the *system throughput plunges*, and the *page-fault rate increases tremendously*.

8. **Solution to Thrashing**: To stop thrashing and increase CPU utilization, the system must **decrease the degree of multiprogramming**, reducing the number of processes in memory. This allows the remaining processes to have *enough frames* to execute efficiently without excessive swapping.

![[Pasted image 20240331005508.png]]

### Limit Thrashing
#### 1. Local replacement algorithm
- When using local replacement in paging, if one process starts thrashing, *it can't take frames from another process* to avoid causing the latter to thrash too. 
- However, this doesn't completely solve the problem. *When processes thrash, they spend most of their time in the paging device queue*. This *increases the average service time* for a page fault because of the longer queue, affecting the effective access time even for a non-thrashing process.

#### 2. Working Set:
- The working-set strategy is a technique used to determine the *number of frames a process needs to prevent thrashing*. It is based on the idea of the working set (locality) of a process, which is the set of pages that the process is currently using.

	- **Locality Model:** A locality is a set of pages that are actively used together. The locality model states that, *as a process executes, it moves from locality to locality*. *Memory reference exhibit locality*.

- The working-set strategy uses the locality model as a basis for determining the number of frames to allocate to a process.
- When enough frames are allocated to a process to accommodate its current locality, the process will initially experience page faults as it brings its required pages into memory. *Once all pages in its locality are in memory, it will not fault again until it changes localities*. However, if an insufficient number of frames are allocated, the process will thrash.

