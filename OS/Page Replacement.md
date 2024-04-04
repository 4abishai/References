
### Page replacement process

1. **Find the Location of the Desired Page on the Disk**:

- When a page fault occurs, the operating system determines the location of the desired page on the disk. This involves accessing disk metadata, such as page tables or other data structures, to identify the page's location.

2. **Find a Free Frame**:

- If there is a free frame available in memory, it is immediately allocated to hold the desired page. The process then proceeds without the need for page replacement.
- If there are no free frames available:
	a. The system initiates a page-replacement algorithm to select a **victim frame**. This algorithm decides which page currently residing in memory will be replaced with the new page.
	b. *The selection of the victim frame is based on specific criteria determined by the page-replacement algorithm*, such as least recently used (LRU), FIFO (First In, First Out), or others.
	c. Once the victim frame is selected, *its contents are written to the disk* (swap space), effectively swapping it out of memory. The *page and inner tables are updated* accordingly to reflect that the page is no longer in memory.

3. **Read the Desired Page into the Newly Freed Frame**:

- After freeing a frame by swapping out its contents, *the desired page is read from disk into the freed frame in memory*. This involves fetching the page's data from disk and loading it into the allocated frame.
- The *page and inner tables are updated* to reflect the new mapping of the page to the frame.

4. **Continue the User Process**:

- With the desired page now in memory, the user process can resume execution from where the page fault occurred.
- The program counter is adjusted to restart execution at the instruction that caused the page fault, ensuring that the process continues seamlessly.

### Modify Bit (Dirty Bit)

- Each page or frame in memory has an associated modify bit, managed by the hardware.
- Only writes modified pages back to the disk.

The text describes a technique to reduce the overhead of page faults by using a modify bit, also known as a dirty bit. Here's how it works and how it helps optimize page replacement:

#### Page Replacement with Modify Bit:
   
   - When selecting a page for replacement, the operating system examines its modify bit to determine whether the page has been modified since it was read into memory.
   - If the *modify bit is set (indicating that the page has been modified)*, the page must be *written back* to the disk before it can be replaced. This ensures that any changes made to the page are persisted to disk.
   - If the *modify bit is not set (indicating that the page has not been modified)*, the page *does not need to be written back* to the disk because its contents are already up-to-date on the disk.
   - This optimization applies not only to writable pages but also to read-only pages. Since read-only pages cannot be modified, they can be discarded when desired without the need for writing them back to disk.

#### Reduction in I/O Time:
   
   - By utilizing the modify bit, the time required to service a page fault can be significantly reduced.
   - *If the modify bit is not set (indicating no modifications to the page), the page does not need to be written back to disk, effectively halving the I/O time required for page replacement.*
   - This optimization is particularly beneficial for pages that are *frequently read but rarely modified*, as it reduces unnecessary disk writes
   - It speeds up the page replacement process.

In summary, the use of a modify bit helps reduce the overhead of page faults by minimizing unnecessary disk writes during page replacement. By only writing modified pages back to disk, the technique effectively halves the I/O time required for page replacement, resulting in faster and more efficient handling of page faults.

### Reference String

**Reference string**: sequence of memory references
#### Generation of Reference String:
   
   - A reference string consists of memory references, typically represented by page numbers.
   - Reference strings can be generated artificially using random number generators or traced from a running system, where the address of each memory reference is recorded.

#### Reduction of Data:
   
- When tracing a system to record memory references, the large amount of data can be reduced by considering two key facts:
	 a. For a given page size (fixed by hardware or system), only the *page number needs to be considered*, not the entire address.
	 b. If a reference is made to a particular page (e.g., page p), *subsequent references to the same page immediately following it will not cause a page fault*, as the page will already be in memory.

#### Example of Reducing Reference String:
   
   - The text provides an example reference string and reduces it based on the page size:
 ```css
 Original reference string: 0100, 0432, 0101, 0612, 0102, 0103, 0104, 0101,...
 Reduced reference string (with 100 bytes per page): 1, 4, 1, 6, 1, 6, 1,...
 ```
   - This reduced reference string simplifies analysis and reduces the amount of data.
#### Determining Page Faults:
   
   - To **evaluate a page-replacement algorithm**, the number of *page faults for a particular reference string* and number of *page frames available* is determined.
   - The number of page faults is influenced by the number of page frames available. As the number of frames available increases, the number of page faults decreases.
![[Pasted image 20240403001926.png]]
## Types of Page Replacement Algorithm:

### FIFO (First In First Out)

- FIFO associates a time stamp with each page brought into memory. When a page replacement is necessary, the oldest page in memory (the one brought in earliest) is chosen for replacement.
- This algorithm is implemented using a FIFO queue where pages are inserted at the tail and replaced from the head of the queue.
- Even *if we select for replacement a page that is in active use*, everything still works correctly. After we replace an active page with a new one, a fault occurs almost immediately to retrieve the active page. Some other page must be replaced to bring the active page back into memory. Thus, *a bad replacement choice increases the page-fault rate and slows process execution*. It does not, however, cause incorrect execution.
![[Pasted image 20240403001853.png]]
#### Belady's Anomaly:

- Belady's anomaly is an unexpected phenomenon observed in some page-replacement algorithms, including FIFO.
- It refers to cases where *increasing the number of available memory frames* leads to *more page faults instead of fewer*, which contradicts the common expectation that more memory should improve performance.

### Optimal Page Replacement Algorithm

- OPT (or MIN) is designed to achieve the lowest possible page-fault rate among all page-replacement algorithms.
- The key idea is to *replace the page that will not be accessed for the longest duration in the future*.
- This algorithm guarantees the *lowest possible page-fault rate* for a fixed number of frames.
- OPT outperforms FIFO significantly, especially considering that the initial three page faults are unavoidable for any algorithm.
![[Pasted image 20240403002220.png]]
#### Difficulty of Implementation:

- Despite its effectiveness, the optimal algorithm is challenging to implement in practice because it *requires knowledge of future memory references*.
- Similar to Shortest Job First (SJF) CPU-scheduling algorithm, which requires knowledge of CPU burst times, the optimal page-replacement algorithm faces the challenge of needing future information.
#### Usage of Optimal Algorithm:

- Due to the impracticality of implementing the optimal algorithm, it is primarily used for *comparison studies*.
- Researchers may use it to *benchmark* new page-replacement algorithms against the optimal one to assess their effectiveness.

### (LRU) Least Recently Used

#### LRU Page-Replacement Algorithm:
   
   - LRU replacement associates with each page the time of its last use.
   - When a page replacement is necessary, LRU selects the *page that has not been used for the longest period of time*.
   - LRU effectively looks backward in time to choose the page for replacement, based on recent past usage.
![[Pasted image 20240403002424.png]]
#### Comparison with FIFO:
   - **FIFO**: Replaces *oldest page brought into memory*
   - **LRU**: Replaces *oldest referenced page present in the memory*

#### Implementation Challenges:
   
   - While LRU is considered a good page-replacement algorithm, its implementation can be challenging, especially in systems without substantial hardware assistance.
   - Two feasible implementations are discussed:
 
	 - **Time-of-use field**: Each page-table entry includes a *time-of-use field*, and a logical clock or *counter* (CPU) is incremented for every memory reference. 
       Whenever a reference to a page is made, the *contents of the clock register are copied to the time-of-use field* in the page-table entry for that page.
       The time-of-use field is updated for each page reference, and the *page with the smallest time value is replaced*.
 
     - **Stack**: Pages are maintained in a stack based on their usage. The *most recently used page is placed at the top of the stack*, and the *least recently used page is at the bottom*. 
       Implementing this approach requires managing a doubly linked list with pointers to efficiently update the stack. As a result each update is a little more *expensive*, but there is *no search* for a replacement.

#### Advantages:
   
   - LRU replacement, like optimal replacement, does not suffer from Belady's anomaly. It belongs to a class of page-replacement algorithms known as stack algorithms.
   - **Stack algorithms** ensure that increasing the number of frames always *retains the set of most recently referenced pages* in memory.
	   - It refers to a class of algorithms where the *set of pages in memory for n frames is always a subset of the set of pages that would be in memory with n + 1 frames*. In simpler terms, it means that *adding more memory frames will never result in fewer pages being retained in memory*.
	   - For LRU replacement, which evicts the least recently used page when a new page needs to be brought into memory, the set of pages in memory would consist of the n most recently referenced pages. The LRU policy ensures that the pages that are accessed most recently are retained in memory.
	   - They never exhibit Belady's anomaly.
	
#### Hardware Assistance:
   
   - Implementing LRU requires hardware support beyond standard TLB registers due to the need for frequent updates to *time-of-use fields or stacks*.
   - Updating these data structures for every memory reference would introduce significant overhead, potentially slowing down system performance.
