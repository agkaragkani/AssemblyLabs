# MIPS Assembly Language Labs

[cite_start]**Course:** HRY 201 - Digital Computers (Digital Systems & Computer Architecture) [cite: 405]
**Environment:** MIPS32 Assembly (MARS/SPIM Simulator)

This repository contains a collection of laboratory exercises demonstrating proficiency in low-level programming, memory management, stack manipulation, and control flow in MIPS Assembly.

---

## 📂 Lab Breakdown

### 1. Basic I/O & System Calls (Lab 1)
**Focus:** Introduction to `syscall`, data types, and register manipulation.
* [cite_start]**String Handling:** Prompts the user for a string input and prints it back formatted as "Hello [string] World!"[cite: 142].
* [cite_start]**Integer Arithmetic:** Accepts an integer input, doubles the value using a logical shift left (`sll`), and prints the result[cite: 199, 200, 244].
* [cite_start]**Character I/O:** Reads a single character and outputs it in a formatted string[cite: 261].

### 2. Integer Calculator (Lab 2)
**Focus:** Branching logic and arithmetic operations.
* [cite_start]Implemented a calculator that accepts two integers and an operator [cite: 326-329].
* [cite_start]**Supported Operations:** Addition (`+`), Subtraction (`-`), Multiplication (`*`), and Division (`/`)[cite: 316, 338, 355].
* Uses conditional branching to route the program flow to the correct arithmetic instruction based on the user's input char.

### 3. String Processing & Filtering (Lab 3)
**Focus:** Byte-level manipulation and ASCII processing.
* [cite_start]**Input:** Accepts complex strings containing mixed case letters, numbers, and special symbols (e.g., `InPUt#WiTH$$$ NumBerS@123`)[cite: 389].
* **Algorithm:**
    * Iterates through the string byte-by-byte.
    * Converts uppercase letters to lowercase.
    * [cite_start]Filters out special characters, retaining only alphanumeric content[cite: 390].
* **Output:** Cleaned, lowercase sentences (e.g., `input with numbers 123`).

### 4. Phonebook Application (Lab 4)
[cite_start]**Focus:** Data Structures, Stack Management, and Nested Subroutines[cite: 408].
* [cite_start]**Functionality:** A dynamic phonebook capable of storing up to 10 entries[cite: 416].
* **Data Structure:** Implemented a "Struct" concept in memory using offsets. [cite_start]Each entry contains 3 fields (max 20 chars each): Last Name, First Name, Phone Number[cite: 414, 415].
* **Operations:**
    * [cite_start]**Entry (E):** Add a new contact to the stack/memory[cite: 422].
    * [cite_start]**Inquiry (I):** Retrieve a contact using its index number[cite: 442, 447].
    * **Quit (Q):** Terminate the program.
* [cite_start]**Technical Concept:** Utilized **Nested Procedures** (`main` -> `Prompt` -> `Get_Entry`), requiring careful management of the Stack Pointer (`$sp`) to save return addresses (`$ra`)[cite: 455].

### 5. Recursive Fibonacci Sequence (Lab 5)
**Focus:** Recursion and Input Validation.
* [cite_start]**Goal:** Calculate the Nth Fibonacci number ($F_n = F_{n-1} + F_{n-2}$)[cite: 368].
* **Features:**
    * [cite_start]**Input Validation:** Ensures user input is within the calculation range (0-24)[cite: 129, 362].
    * **Recursion:** Implements the Fibonacci algorithm using recursive function calls.
    * [cite_start]**Exit Condition:** Input of `-1` terminates the program[cite: 371].

---

## 🛠 Technical Skills Demonstrated
* **MIPS Instruction Set:** `lw`, `sw`, `li`, `la`, `move`, `syscall`, `beq`, `bne`, `jal`, `jr`.
* **Memory Management:** Direct memory addressing and offset calculations for struct-like data storage.
* [cite_start]**Stack Operations:** Managing `$sp` for local variables and preserving `$ra` during nested and recursive calls[cite: 412].
* [cite_start]**Logic:** Flowcharts designed to map control flow before implementation[cite: 361].

---

## 🚀 How to Run
1.  Install **MARS** (MIPS Assembler and Runtime Simulator).
2.  Open the desired `.asm` file.
3.  Assemble the code (F3).
4.  Run the executable (F5).
5.  Interact via the Console/Run I/O tab.