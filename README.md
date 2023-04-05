# Assembly

### To run assembly code on Windows Terminal

```
nasm -f win32 <file>.asm

gcc <file>.obj -o <file>.exe
```

### To run assembly code on Linux

``` asm
nasm -f elf <file>.asm

e ld -m elf_i386 -s -o <file> <file>.o

./<file>
```
