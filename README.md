# Assembly

```
nasm -f elf64 <file>.asm

ld -o name <file>.o

./name
```

### To run assembly code on Linux

``` asm
nasm -f elf <file>.asm

e ld -m elf_i386 -s -o <file> <file>.o

./<file>
```
