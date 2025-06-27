# Code Explanation

```asm
[org 0x7C00]
```

- BIOS loads the bootloader at address `0x7C00` in memory.
- This tells the assembler the code will start at that address.

```asm
mov si, message
```

- Load the address of the string `"Press a key"` into register `SI`.
- `SI` will be used to read characters one by one.

```asm
print_loop:
    lodsb
```

- `LODSB` = Load byte from `[SI]` into `AL`, and increment `SI`.
- This reads the next character of the message.

```asm
    or al, al
```

- Bitwise OR `AL` with itself : to set flags.
- If `AL` is zero (i.e., end of the string), the Zero Flag is set.

```asm
    jz wait_key
```

- Jump to `wait_key` if the Zero Flag is set (i.e., null terminator was read).
- Otherwise, continue printing the next character.

```asm
    mov ah, 0x0E
    int 0x10
```

- BIOS **video interrupt** `int 0x10` with **function 0x0E** (teletype mode).
- It prints the character in `AL` to the screen.
- `AH = 0x0E` tells BIOS what kind of video service we want.
- `int 0x10` triggers the BIOS interrupt.

```asm
    jmp print_loop
```

- Go back and print the next character of the string.

```asm
wait_key:
    mov ah, 0x00
    int 0x16
```

- BIOS **keyboard interrupt**: `int 0x16`, function 0x00.
- This **waits for a key press**.
- After the key is pressed:
  - `AL` = ASCII of the key
  - `AH` = scan code

```asm
    mov ah, 0x0E
    int 0x10
```

- Echo the key back to the screen using BIOS teletype (again).
- `AL` still holds the character you pressed.
- `AH = 0x0E` selects the print function again.

```asm
    cli
```

- **Clear Interrupt Flag** — disables hardware interrupts.
- Useful before halting so that no interrupt wakes up the CPU.

```asm
    hlt
```

- **Halt the CPU** — the system stops here until reset.
- This is common in bootloaders that don’t hand off control to anything else.

```asm
message db "Press a key", 0
```

- Defines the string `"Press a key"` as a sequence of bytes.
- The `0` at the end is a **null terminator** — used to detect the end of the string in `print_loop`.

```asm
times 510 - ($ - $$) db 0
```

- Pads the binary to **510 bytes**.
- `($ - $$)` = current offset in file.
- `times ... db 0` fills the rest with zeros.
- A boot sector must be **exactly 512 bytes**, with signature at the end.

```asm
dw 0xAA55
```

- This is the **magic boot signature**.
- BIOS checks for `0x55AA` at byte 511–512.
- If missing, BIOS will reject it as a bootable device.
