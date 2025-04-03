#!/usr/bin/env bash
 
echo "THIS SHOULD ONLY BE RUN IN PROJECT ROOT!"

proj_name="pong"

echo "Finding C and ASM files"
c_files=$(find src -name '*.c')
asm_files=$(find src -name '*.asm')

echo "Ensuring obj and build directories exist"
mkdir -p obj build

echo "Compiling asm files"
i=0
for asm in $asm_files; do
    nasm -f elf64 "$asm" -o "obj/asm_$i.o"
    ((i++))
done

echo "Compiling C files"
echo $c_files

bear -- bash -c '
for c in "$@"; do
    gcc -g -fno-stack-protector -Iinclude -c "$c" -o "obj/$(basename "$c" .c).o"
done' _ $c_files

echo "Linking everything"

ld -o "build/$proj_name" --gc-sections obj/*.o 

if [ "$1" == "run" ]; then    
    echo "Stripping..."
    strip "build/funnyasm"
    echo "Running program..."
    "./build/$proj_name"
elif [ "$1" == "debug" ]; then
    echo "Running program through GDB..."
    gdb -q "./build/$proj_name"
else
    strip "build/$proj_name"
    echo "Build complete"
fi

