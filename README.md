# Assembly

### Run assembly code here: [NASM]('https://www.tutorialspoint.com/compile_assembly_online.php')

or

### To run assembly code on Windows Terminal

```
nasm -f elf54 <file>.asm

ld -o name <file>.o

./name
```

### To run assembly code on Linux

``` asm
nasm -f elf <file>.asm

e ld -m elf_i386 -s -o <file> <file>.o

./<file>
```
