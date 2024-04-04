Demand paging is a memory management technique commonly used in virtual memory systems where *pages are loaded into physical memory only when they are demanded during program execution*. 
This strategy contrasts with the traditional approach of preloading entire programs or processes into memory before execution begins. With demand paging, the operating system loads pages from secondary storage (such as a hard disk) into physical memory only when they are accessed by the executing program.
A demand-paging system is similar to a paging system with swapping where processes reside in secondary memory (usually a disk). When we want to execute a process, we swap it into memory. Rather than swapping the entire process into memory, though, we use a lazy swapper. A **lazy swapper** never swaps a page into memory unless that page will be needed.

### Page level swapping

1. **Predictive Page Swapping**:

- Before swapping in a process, the pager predicts which pages will be needed soon.
- Instead of bringing in the entire process, only these predicted pages are loaded into memory. This aims to minimize the number of unnecessary page swaps and reduce the overhead.

2. **Hardware Support**:

- Page-level swapping requires hardware support to distinguish between pages that are currently in memory and those that are on disk.
- The valid-invalid bit scheme, typically implemented in the page table entries, is used for this purpose.
- When a page is in memory and valid, the associated bit in the page table entry is set to "valid," indicating that the page is both legal and currently in memory.
- If a page is not in memory, the valid-invalid bit is set to "invalid," indicating that the page is either not valid (i.e., not in the logical address space of the process) or is valid but currently on disk.
![[Pasted image 20240402232308.png]]

3. **Handling Page Faults**:

- When a process attempts to access a page that is not currently in memory (a **page fault** occurs), the operating system responds accordingly.
- *If the page is predicted to be needed, the operating system fetches it from disk into an available page frame in physical memory*.
- If the page is not predicted to be needed or is invalid, the operating system may either simply mark the page as invalid or indicate its location on disk in the page table entry.

4. **Execution with Memory-Resident Pages**:

- As the process executes and accesses **memory-resident pages**, execution proceeds normally.
- Pages that are in memory remain accessible to the process, while pages that are not currently needed remain on disk until they are requested.

In summary, page-level swapping optimizes memory usage by bringing only predicted pages into memory, *reducing swap time* and physical memory requirements. This technique leverages hardware support, such as the valid-invalid bit scheme, to efficiently manage page swaps and ensure seamless execution of processes.

### Handling Page Faults contd

1. **Check Validity of Reference**:
- Upon encountering a page fault, the operating system checks an **internal table** associated with the process (often kept in the PCB) to determine *whether the memory access was valid or invalid*.
- If the *reference was invalid* (e.g., accessing memory outside the process's address space), *the process is terminated*. If the reference was valid but the page is not yet in memory, the page fault handling procedure continues.

3. **Page-In Operation**:
- The operating system initiates a page-in operation to bring the page from disk into memory.
- It *locates a free frame in physical memory* to allocate to the incoming page. This can be done by selecting a frame from the free-frame list maintained by the operating system.

4. **Disk Operation**:
- After allocating a free frame, the operating system schedules a disk operation to *read the desired page* from disk into the allocated frame.
- This involves initiating a disk I/O request to fetch the page from the disk storage device.

5. **Update Internal Tables**:
- It updates the process's internal table and the page table to indicate that the page is now in memory and is accessible to the process.

6. **Restart Interrupted Instruction**:
- With the required page now in memory, the operating system restarts the instruction that was interrupted by the page fault.
![[Pasted image 20240403000251.png]]

If further page faults occur, the same procedure is followed to bring in the required pages into memory.

In the extreme case described, where a process starts execution with no pages in memory, the demand-paging system progressively brings in pages as they are accessed. This scheme is **pure demand paging**: never bring a page into memory until it is required.

### Avoidance of multiple page faults

While it's theoretically possible for programs to access several new pages of memory with each instruction execution, resulting in multiple page faults per instruction and potentially causing unacceptable system performance, this scenario is highly unlikely due to the principle of locality of reference.

Locality of reference refers to the *tendency of programs to access memory locations that are close to each other in time or space*. There are two main types of locality:

1. **Temporal Locality**: This refers to the tendency of a program to access the *same memory locations repeatedly over a short period of time*. For example, variables within a loop or recently accessed instructions are likely to be accessed again soon.

2. **Spatial Locality**: This refers to the tendency of a program to access *memory locations that are near each other*. For example, when accessing an array, the program is likely to access nearby elements in the array.


Due to these principles of locality of reference, programs tend to access memory in *predictable patterns*, which results in reasonable performance from demand paging. Instead of causing multiple page faults per instruction, programs typically exhibit clustered memory accesses, allowing demand paging to efficiently bring in only the necessary pages into memory.

### Hardware support

Regarding the hardware support for demand paging, it relies on the same hardware components used for paging and swapping:

1. **Page Table**: This table is used to *map virtual addresses to physical addresses*. It includes mechanisms such as a valid-invalid bit or protection bits to mark entries as valid or invalid, indicating whether a page is currently in memory or needs to be fetched from secondary storage.

2. **Secondary Memory (Swap Device)**: This is the storage medium, typically a high-speed disk, used to *hold pages that are not currently in main memory*. The section of the disk used for this purpose is known as **swap space**. When a page needs to be brought into memory due to a page fault, it is fetched from the swap device.

### Restarting instruction after page fault

The concept of demand paging, where pages are brought into memory only when they are needed, requires the ability to restart any instruction after a page fault. This entails saving the state of the interrupted process, including registers, condition codes, and the instruction counter, so that the process can resume execution exactly where it left off once the required page is loaded into memory.

Here's a detailed explanation of how this requirement is met and the challenges involved, using examples of simple and complex instructions:

1. **Simple Instruction Example**:
   
- Consider a simple three-address instruction like "ADD the content of A to B, placing the result in C."
- If a page fault occurs during the execution of this instruction, such as when trying to store the result in C (if C is a page that's not currently in memory), the following steps are taken:
	 - Get the desired page, bring it into memory, correct the page table, and restart the instruction.
	 - Upon restart, *fetch the instruction again, decode it again*, fetch the two operands again (A and B), and then perform the addition again.
- Despite the repetition, there is minimal redundant work (less than one complete instruction), and the repetition occurs only when a page fault occurs.

2. **Complex Instruction Example**:
- Consider a more complex instruction like the IBM System 360/370 MVC (move character) instruction, which can move up to 256 bytes from one location to another.
- If a page fault occurs during the execution of such an instruction, additional challenges arise:
     - If either block (source or destination) of the move operation *straddles a page boundary*, a page fault might occur after the *move is partially done*.
     - If the source and destination blocks overlap, the *source block may have been modified*, complicating the restart process.
- To address this, two solutions are proposed:
     - One solution involves computing and attempting to *access both ends of both blocks before the move operation*. If a page fault occurs at this step, the move operation is not performed, ensuring that memory remains unchanged.
     - Another solution involves using *temporary registers to hold the values of overwritten locations*. If a page fault occurs, the old values are written back into memory before the trap occurs, restoring memory to its state before the instruction was started, allowing the instruction to be repeated.

Paging is added between the CPU and the memory in a computer system. It should be entirely transparent to the user process. Thus, people often assume that paging can be added to any system.Although this assumption is true for a **non-demand-paging environment**, where a *page fault represents a fatal error*, it is not true where a page fault
means only that an *additional page must be brought into memory* and the process restarted.

In summary, demand paging requires the ability to restart instructions after page faults to ensure seamless execution of processes. While simple instructions may require minimal repetition upon restart, more complex instructions pose additional challenges that must be addressed through careful handling of memory access and state management.

### Performance of Demand Paging

A page fault causes the following sequence to
occur:
1. Trap to the operating system.
2. Save the user registers and process state.
3. Determine that the interrupt was a page fault.
4. Check that the page reference was legal and determine the location of the page on the disk.
5. Issue a read from the disk to a free frame:
	a. Wait in a queue for this device until the read request is serviced.
	b. Wait for the device seek and/or latency time.
	c. Begin the transfer of the page to a free frame.
6. While waiting, allocate the CPU to some other user (CPU scheduling, optional).
7. Receive an interrupt from the disk I/O subsystem (I/O completed).
8. Save the registers and process state for the other user (if step 6 is executed).
9. Determine that the interrupt was from the disk.
10. Correct the page table and other tables to show that the desired page is now in memory.
11. Wait for the CPU to be allocated to this process again.
12. Restore the user registers, process state, and new page table, and then resume the interrupted instruction.

#### Page-fault service time

**Page-Fault Service Time Components**:
   
   - **Service the Page-Fault** (Page In Ops): Actions to resolve the fault, such as locating free frame & fetching the required page from secondary storage.
   - **Read in the Page** (Disk Ops): This involves reading the page from secondary storage into physical memory.
   - **Restart the Process**: This involves restarting the process after the page fault has been resolved.

**Time Estimates**:
   
   - The first and third tasks (servicing the page-fault and restarting the process) can be reduced to several hundred instructions, each taking from 1 to 100 microseconds.
   - The page-switch time, which includes reading in the page from secondary storage, is estimated to be close to 8 milliseconds. This includes the average latency of the hard disk (3 milliseconds), seek time (5 milliseconds), and transfer time (0.05 milliseconds).

#### Effective Access Time 

 ```css
 effective access time = (1 - p) × (memory access time) + p × (page-fault service time)
 ```
 
 where:
 - p is  probability of a page fault (0 ≤ p ≤ 1). We would expect p to be close to zero—that is, we would expect to have only a few page faults.
 - Memory access time is typically 200 nanoseconds.
 - Page-fault service time is estimated to be 8 milliseconds.

**Substituting the values**:

```css
effective access time = (1 - p) × 200 + p × 8,000,000
= 200 + 7,999,800 × p
```
- there are 10^6 nanoseconds in a millisecond.

This formula provides the effective access time in nanoseconds as a function of the probability of a page fault (p).

1. **Direct Proportionality between Page-Fault Rate and Effective Access Time**:

   - If the page-fault rate is high, the system spends more time handling page faults, leading to longer effective access times and slower overall performance.

2. **Performance Degradation Threshold**:
   
   - To maintain performance degradation at a reasonable level (less than 10 percent), the page-fault rate needs to be kept low.
   - The inequality derived from the effective access time calculation indicates that to keep the slowdown due to paging below 10 percent, the page-fault rate should be less than 0.0000025.
   - This translates to allowing fewer than one memory access out of 399,990 to result in a page fault.

3. **Importance of Low Page-Fault Rate**:
   
   - In summary, it is crucial to keep the page-fault rate low in a demand-paging system to ensure efficient performance.
   - A high page-fault rate can dramatically increase the effective access time, significantly slowing down process execution.

In conclusion, maintaining a low page-fault rate is essential for optimal performance in demand-paging systems.