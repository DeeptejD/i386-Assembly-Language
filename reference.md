
> The data section is used to hold all constants, filenames and buffers. this data does not change during runtime

```
section .data
```

> The bss section (block started by symbol) is used to hold variable

```
section .bss
```

> The text section is ued to hold actual code. it starts with global main which tells the kernel where to beign the execution

```
section .text
    global main
main:
```

> Comments in assembly being w a semicolon

``` asm
;this is a comment
```

> 