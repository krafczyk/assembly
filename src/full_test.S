	.text
	.section	.rodata
data0:
	.string	"begin"
data1:
	.string	"loop-start i=%llu high=%llu low=%llu\n"
dataresult:
    .string "F[%llu]= %llu\n"
tester:
    .string "%llu %llu %llu\n"
tester2:
    .string "rsp=%p\n"
tester3:
    .string "val=%llu\n"
	.text
	.globl	main
	.type	main, @function
main:
    // Set stack pointer to correct location
    pushq %rbp
    movq %rsp,%rbp

    // Save number of steps
    subq $8, %rsp
    movq $10,-8(%rbp)

    // Initialize
    movq -8(%rbp),%rsi
    movq $0,%rcx
    movq $1,%rax

loopstart:
    // Swap
    xorq %rcx,%rax
    xorq %rax,%rcx
    xorq %rcx,%rax

    // Iterate
    addq %rcx,%rax
 
    // Decrement and jump if zero
    decq %rsi
    jnz loopstart

    // Report answer
    movq %rax,%rdx
    movq -8(%rbp),%rsi
	leaq dataresult(%rip), %rdi
	movq $0, %rax
	call printf@PLT

    // Return from function
    movq $0,%rax
    addq $8,%rsp
    leave
    ret
