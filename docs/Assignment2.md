
### Code Explanation

#### `bits 16`

* 16-bit code mode
* Instruction set for real mode

#### `org 0x7c00`

* Origin address set to 0x7C00
* Standard BIOS load address for boot sector

---

### Initialization

#### `mov si, 0`

* Zeroing SI register
* Index start for string printing

---

### `print:` (label)

* Loop label for printing characters

#### `mov ah, 0x0e`

* BIOS teletype output function
* Text output using interrupt 0x10

#### `mov al, [hello + si]`

* Load character from string into AL
* Indexed addressing using SI

#### `int 0x10`

* BIOS interrupt call
* Display character in AL

#### `add si, 1`

* Increment string index
* Move to next character

#### `cmp byte [hello + si], 0`

* Compare next character to null
* Check for end of string

#### `jne print`

* Jump back to print if not null
* Continue loop until string ends

---

### Infinite Halt

#### `jmp $`

* Infinite loop
* Prevent further execution

---

### Data Definition

#### `hello:`

* String label
* Reference point for data

#### `db "Hello World !", 0`

* Define byte string
* Null-terminated message

---

### Boot Sector Padding and Signature

#### `times 510 - ($ - $$) db 0`

* Fill remaining bytes with zeroes
* Total size becomes 510 bytes

#### `dw 0xAA55`

* Boot signature (magic number)
* Required for BIOS boot recognition

---