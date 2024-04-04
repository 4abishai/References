## Hardware Implementation

The hardware implementation of the page table is a crucial aspect of modern computer architecture, particularly in systems that utilize virtual memory management techniques like paging. Here's a detailed note on the hardware implementation of the page table:

#### 1. Dedicated Registers:

   - In simpler systems, especially those with small page tables, the page table can be implemented using dedicated registers.
   - Registers are designed with high-speed logic to facilitate efficient paging-address translation.
   - Each register corresponds to an entry in the page table, and the CPU dispatcher reloads these registers as needed.
   - Examples include architectures like the DEC PDP-11, where the page table is implemented with a set of dedicated registers.

#### 2. Page Table in Main Memory:

   - In contemporary systems with large page tables, storing the page table in dedicated registers is not feasible.
   - Instead, the page table resides in main memory, and a special register called the **Page-Table Base Register (PTBR)** points to the *base address of the page table*.
   - Changing page tables involves updating only the PTBR, significantly reducing context-switch time.

 _Accessing Memory Locations_
   - Accessing a memory location involves indexing into the page table using the PTBR and the page number.
   - This indexing operation requires a memory access to retrieve the corresponding frame number.
   - After obtaining the frame number, it is combined with the page offset to generate the actual physical address.
   - Thus, **two memory accesses are typically needed to access a byte**: one for the *page-table entry* and one for the *byte itself*, resulting in a slowdown.

#### 3. Translation Look-aside Buffer (TLB):

   - To mitigate the performance impact of accessing the page table in memory, modern CPUs employ a special hardware **cache** called the **Translation Look-aside Buffer (TLB)**.
   - The TLB is a small, fast-lookup cache that stores recently accessed page-table entries.
   - Each TLB entry consists of a *key (or tag)* and a *value*, where the key corresponds to a page number, and the value is the corresponding frame number.
   - When a logical address is generated, the CPU first checks the TLB for the page number.
   - If the page number is found in the TLB (**TLB hit**), the corresponding frame number is retrieved instantly, *avoiding the need for a memory access to the page table*.
   - TLB lookup is typically performed as part of the CPU instruction pipeline, adding *minimal performance overhead*.
![[Pasted image 20240402220918.png]]

_Handling TLB Misses_
   - If the page number is not found in the TLB (TLB miss), a memory reference to the page table must be made.
   - Depending on the CPU architecture, this may be handled automatically in hardware or by triggering an interrupt to the operating system.
   - Once the frame number is obtained from the page table, it is used to access memory, and *the page number and frame number are added to the TLB for future references*.
   - If the TLB is full, a *replacement policy is used to select an entry for eviction*, which can range from Least Recently Used (LRU) to round-robin or random replacement.
   - Some TLBs allow certain entries to be "*wired down*," meaning they cannot be evicted, typically for *critical kernel code*.

Overall, the hardware implementation of the page table, coupled with TLB caching, plays a critical role in improving memory access efficiency and overall system performance in modern computer architectures.


### Address-Space Identifiers (ASIDs):

- ASIDs are *unique identifiers assigned to each process* and stored in TLB entries.
- ASIDs allow TLBs to contain *entries for multiple processes simultaneously*, facilitating *faster context switches* without the need to flush the TLB.
- They are used to provide *address-space protection*, ensuring that memory accesses are confined to the appropriate address space of the currently running process.

### TLB Hit Ratio:

- The hit ratio of a TLB is the percentage of times that the desired page number is found in the TLB.
- For example, an 80-percent hit ratio implies that 80 percent of the time, the TLB contains the translation information needed for a memory access.
- Hit ratio is a critical metric for evaluating TLB performance and overall system efficiency.

### Effective Memory Access Time Calculation:

   - The effective memory access time takes into account both *TLB hits* and *TLB misses*.
   - If the page number is found in the TLB (TLB hit), the memory access time is equal to the time it takes to access memory (e.g., 100 nanoseconds).
   - If the page number is not found in the TLB (TLB miss), additional time is required to access the page table and retrieve the frame number before accessing memory.
   - The effective memory access time is calculated by weighting the hit and miss scenarios by their respective probabilities.

### Impact of Hit Ratio on Access Time:

   - A higher *hit ratio results in a lower effective memory access time*, as TLB hits are faster than TLB misses.
   - For example, with an 80-percent hit ratio, the effective access time is 120 nanoseconds, representing a 20-percent slowdown compared to accessing memory directly.
   - Conversely, a 99-percent hit ratio leads to an effective access time of 101 nanoseconds, with only a 1 percent slowdown in access time.
   - Therefore, increasing the hit ratio through efficient TLB management techniques is crucial for minimizing memory access latency and improving overall system performance.
![[Pasted image 20240402222013.png]]
![[Pasted image 20240402222023.png]]

In summary, ASIDs in TLBs facilitate address-space protection and efficient process switching, while hit ratios play a significant role in determining the effectiveness of TLB caching and overall memory access performance.

## Protection

### Valid-Invalid Bit

- Each entry in the page table is associated with a valid-invalid bit. 
- When this bit is set to valid, it indicates that the *corresponding page is part of the process's logical address space and is accessible*. Conversely, when set to invalid, it signifies that the page is not part of the process's address space, and any attempt to access it will result in an error.
- **Memory Protection:** The valid-invalid bit plays a crucial role in memory protection by preventing unauthorized access to memory. It ensures that *processes can only access memory regions that belong to them*, preventing illegal memory accesses and potential security vulnerabilities.
![[Pasted image 20240402222421.png]]

For example, with a 14-bit address space and a 2 KB page size, the valid-invalid bit is used to check the validity of addresses. Any attempt to access addresses beyond the valid range specified for the process will result in a trap to the operating system, indicating an invalid page reference.

### Disadvantage

The example also illustrates a problem with internal fragmentation in paging. Because of the fixed page size, there may be unused address space within a page, leading to inefficiencies in memory utilization.

### Page Table Size Optimization

To mitigate the overhead of maintaining large page tables for processes that only utilize a small fraction of their address space, some systems provide hardware support, such as a **page-table length register (PTLR)**. This register *indicates the size of the page table and is used to verify the validity of logical addresses*. If an address falls outside the valid range specified by the PTLR, an error trap is generated.

# Hierarchical paging

- The page table itself is also paged.
- Hierarchical paging is a memory management technique used in modern computer systems to address the challenges posed by *large logical address spaces, where the size of the page table becomes impractical*. It involves dividing the page table into smaller, more manageable pieces. 
- One approach to hierarchical paging is the two-level paging algorithm.
- **Two-Level Paging:** In two-level paging, the page table itself is organized as a hierarchy. Instead of a single large page table, there are two levels of page tables: an outer page table and multiple inner page tables.
- **Outer Page Table:** The outer page table is the first level of the hierarchy. It contains *page number that map to inner page number*.
- **Inner Page Tables:** The inner page tables are the second level of the hierarchy. They contain entries that map *page numbers to frame numbers*.
![[Pasted image 20240402224103.png]]
- **Address Translation:** To translate a logical address into a physical address, the operating system uses the *outer page table* to locate the appropriate inner page table based on the *higher-order bits* of the page number. Then, it uses the *inner page table* to find the physical frame number corresponding to the *lower-order bits* of the page number.
![[Pasted image 20240402224445.png]]
	For example, consider again the system witha 32-bit logical address space and a page size of 4 KB. A logical address is divided into a page number consisting of 20 bits and a page offset consisting of 12 bits. Because we page the page table, the page number is further divided into a 10-bit page number and a 10-bit page offset. Thus, a logical address is as follows:
	![[Pasted image 20240402224621.png]]

- **Forward-Mapped Page Table:** Because the address translation works from the outer page table inward, this scheme is also known as a forward-mapped page table.

### Advantages

- Hierarchical paging allows for more efficient use of memory by dividing the page table into smaller pieces, reducing the memory overhead associated with large logical address spaces. It also facilitates better memory management and address translation, particularly in systems with large address spaces.