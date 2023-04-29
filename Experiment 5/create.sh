#!/bin/bash

echo "Enter asm file name: "
read filename

nasm -f elf64 "$filename" -o output.o

echo "Enter obj file name: "
read obj

ld -o "$obj" output.o

echo "----------------------"

./"$obj"