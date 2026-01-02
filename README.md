# MIPS Assembly Language Labs

**Course:** HRY 201 - Digital Computers (Digital Systems & Computer Architecture) 
**Environment:** MIPS32 Assembly (MARS/SPIM Simulator)

This repository contains a collection of laboratory exercises demonstrating proficiency in low-level programming, memory management, stack manipulation, and control flow in MIPS Assembly.

---

## 📂 Lab Breakdown

### 1. Basic I/O & System Calls (Lab 1)
**Focus:** Introduction to `syscall`, data types, and register manipulation.
**String Handling:** Prompts the user for a string input and prints it back formatted as "Hello [string] World!".
**Integer Arithmetic:** Accepts an integer input, doubles the value using a logical shift left (`sll`), and prints the result.
**Character I/O:** Reads a single character and outputs it in a formatted string.

### 2. Integer Calculator (Lab 2)
**Focus:** Branching logic and arithmetic operations.
Implemented a calculator that accepts two integers and an operator.
**Supported Operations:** Addition (`+`), Subtraction (`-`), Multiplication (`*`), and Division (`/`).
Uses conditional branching to route the program flow to the correct arithmetic instruction based on the user's input char.

### 3. String Processing & Filtering (Lab 3)
**Focus:** Byte-level manipulation and ASCII processing.
**Input:** Accepts complex strings containing mixed case letters, numbers, and special symbols (e.g., `InPUt#WiTH$$$ NumBerS@123`).
* **Algorithm:**
    * Iterates through the string byte-by-byte.
    * Converts uppercase letters to lowercase.
    * Filters out special characters, retaining only alphanumeric content.
* **Output:** Cleaned, lowercase sentences (e.g., `input with numbers 123`).

### 4. Phonebook Application (Lab 4)
**Focus:** Data Structures, Stack Management, and Nested Subroutines.
**Functionality:** A dynamic phonebook capable of storing up to 10 entries.
**Data Structure:** Implemented a "Struct" concept in memory using offsets. Each entry contains 3 fields (max 20 chars each): Last Name, First Name, Phone Number.
* **Operations:**
    **Entry (E):** Add a new contact to the stack/memory.
    **Inquiry (I):** Retrieve a contact using its index number.
    **Quit (Q):** Terminate the program.
**Technical Concept:** Utilized **Nested Procedures** (`main` -> `Prompt` -> `Get_Entry`), requiring careful management of the Stack Pointer (`$sp`) to save return addresses (`$ra`).

### 5. Recursive Fibonacci Sequence (Lab 5)
**Focus:** Recursion and Input Validation.
**Goal:** Calculate the Nth Fibonacci number ($F_n = F_{n-1} + F_{n-2}$).
* **Features:**
    **Input Validation:** Ensures user input is within the calculation range (0-24).
    **Recursion:** Implements the Fibonacci algorithm using recursive function calls.
    **Exit Condition:** Input of `-1` terminates the program.

---

## 🛠 Technical Skills Demonstrated
* **MIPS Instruction Set:** `lw`, `sw`, `li`, `la`, `move`, `syscall`, `beq`, `bne`, `jal`, `jr`.
* **Memory Management:** Direct memory addressing and offset calculations for struct-like data storage.
* **Stack Operations:** Managing `$sp` for local variables and preserving `$ra` during nested and recursive calls.
* **Logic:** Flowcharts designed to map control flow before implementation.

---

## 🚀 How to Run
1.  Install **MARS** (MIPS Assembler and Runtime Simulator).
2.  Open the desired `.asm` file.
3.  Assemble the code (F3).
4.  Run the executable (F5).

5.  Interact via the Console/Run I/O tab.
