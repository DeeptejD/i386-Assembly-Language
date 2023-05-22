# Assembly

### 64 Bit
```
nasm -f elf64 <file>.asm

ld -o name <file>.o

./name
```

### 32 Bit
```
nasm -f elf32 <file>.asm

ld -m elf_i386 -o <file>.exe <file>.oś

./name
```

``` asm
nasm -f elf <file>.asm

e ld -m elf_i386 -s -o <file> <file>.o

./<file>
```
