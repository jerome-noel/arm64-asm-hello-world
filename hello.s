.global _start

// note that .align can be target specific. 
// .p2align is explicitely a power of 2. 
// Could also use .balign 4 - this is explicitely lineay
// My understanding is that one align directive is required before each section
// the compiler complained at some point (for the strings)
.p2align 2 
_start:
    b _printf
    b _terminate

// in general those syscalls work by putting the parameter in the first X registers
// then putting the relevant syscall number in X16
// see https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master

.p2align 2 
_printf:
    mov X0, #1      // stdout
    adr X1, hello   // address of hellow world string
    mov X2, #12     // length of the string
    mov X16, #4     // write 
    svc 0           // syscall (0 is the syscall number for arm64)
    ret             // add this otherwise the code continues to the next section!!

.p2align 2 
_reboot:
    mov X0, #1      // instant reboot
    mov X16, #55    // reboot 
    svc 0           // syscall
    ret

.p2align 2 
_terminate:
    mov X0, #0      // return 0
    mov X16, #1     // terminate 
    svc 0           // syscall 
    ret

.p2align 2
hello:
    .asciz "hello world\n"
