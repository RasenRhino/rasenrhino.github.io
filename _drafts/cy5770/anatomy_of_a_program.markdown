(for a 32 bit system)
Each process in a multi-tasking OS runs in its own memory sandbox. This sandbox is the **virtual address space**, which in 32-bit mode is always a **4GB block of memory addresses**.

##### Page Table 
These virtual addresses are mapped to physical memory by page tables, which are maintained by the operating system kernel and consulted by the processor.