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
	.text
	.globl	main
	.type	main, @function
main:
    // Set stack pointer to correct location
    pushq %rbp
    movq %rsp,%rbp

    // Save number of steps
    subq $16, %rsp
    movq $10,-8(%rsp)

    // Initialize
    movq -8(%rsp),%rsi
    movq $0,%rcx
    movq $1,%rax

    pushq %rsi
    pushq %rcx
    pushq %rax
    pushq %rsp
    leaq data0(%rip), %rdi
    call puts
    popq %rsp
    popq %rax
    popq %rcx
    popq %rsi

loopstart:
    pushq %rsi
    pushq %rcx
    pushq %rax
    pushq %rsp
    movq %rax,%rdx
	leaq data1(%rip), %rdi
	movq $0, %rax
	call printf@PLT
    popq %rsp
    popq %rax
    popq %rcx
    popq %rsi

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
    pushq %rsi
    pushq %rcx
    pushq %rax
    pushq %rsp
    movq %rax,%rdx
    movq 8(%rsp),%rcx
    movq (%rsp),%rdx
    movq -8(%rsp),%rsi
	leaq tester(%rip), %rdi
	movq $0, %rax
	call printf@PLT
    popq %rsp
    popq %rax
    popq %rcx
    popq %rsi

    // Report answer
    pushq %rsi
    pushq %rcx
    pushq %rax
    pushq %rsp
    movq %rax,%rdx
    movq -8(%rsp),%rsi
	leaq dataresult(%rip), %rdi
	movq $0, %rax
	call printf@PLT
    popq %rsp
    popq %rax
    popq %rcx
    popq %rsi

    // Return from function
    add $16,%rsp
    popq %rbp
    movq $0,%rax
    ret
