.data
numero1:    .word 0
numero2:    .word 0
operador:   .word ' '
mensaje_sum1: .asciz " sumado con "
mensaje_sum2: .asciz " es igual a: "
mensaje_resta:  .asciz "%d restado con %d es: %d "
mensaje_multiplicacion: .asciz "%d multiplicado con %d es: %d "
mensaje_division:	.asciz "%d dividido entre %d es igual a: %d con residuo: %d"
mensaje_cancelarDivision: .asciz "No se puede dividir por cero"

.text
main:       
	ldr r4, =numero1
	str r0, [r4]
	ldr r5, =numero2
	str r1, [r5]
	ldr r6, =operador
	str r2, [r6]
    	cmp r2, #'+'
    	beq suma
    	cmp r2, #'-'
    	beq resta
    	cmp r2, #'*'
    	beq multiplicacion
    	cmp r2, #'/'
    	beq division
    	b stop
    
suma: 	mov r6, r0
	mov r4, r1
	mov r0, #0 @ para reiniciar r0 y r1 r0: col y r1: fil
	mov r1, #0 
	mov r2, r6
	bl printInt
	mov r1, #0 @para que quede seguido
	mov r5, #0
	add r5,r5, r0
	mov r0, r5
	ldr r2, = mensaje_sum1
	bl printString
	mov r1, #0 @para que quede seguido
	add r5,r5, r0
	mov r0, r5
	mov r2, r4
	bl printInt
	mov r1, #0 @para que quede seguido
	add r5,r5, r0
	mov r0, r5
	ldr r2, =mensaje_sum2
	bl printString
	mov r1, #0 @para que quede seguido
	add r5,r5, r0
	mov r0, r5
	add r7, r6, r4 @resultado en r7
	mov r4, #0 
	mov r6, #0
	mov r2, r7
	bl printInt
	b loadRegisters
    	b stop
resta:	mov r3, r0
	sub r7, r0, r1 @resultado en r7
	sub sp, sp, #8
	str r7, [sp, #4]
	str r1, [sp]
	mov r0, r0
	mov r0, #0
	mov r1, #0
	ldr r2, =mensaje_resta
	bl  printf	
	add sp, sp, #8 
	b loadRegisters
    	b stop
multiplicacion: @resultado en r7
	mov r3, r0
	mov r6, r1
    	mul r1, r0, r1
	mov r7, r1
	sub sp, sp, #8
	str r1, [sp, #4]
	str r6, [sp]
	mov r0, r0
	mov r0, #0
	mov r1, #0
	ldr r2, =mensaje_multiplicacion
	bl  printf	
	add sp, sp, #8
	b loadRegisters
	b stop	

division: 
	cmp r1, #0
	beq dontDivide
	mov r4, r0
	mov r6, r1
	bl  sdivide 
	sub sp, sp, #12    
	str r1, [sp, #8]
	str r0, [sp, #4]
	str r6, [sp]
	mov r3, r4
	mov r7, r0 @para el resultado
	mov r0, #0
	mov r6, r1 @para no perder el registro del residuo
	mov r1, #0
	ldr r2, =mensaje_division
	bl  printf	@ Imprime dividendo, divisor, residuo y resultado
	add sp, sp, #8
	b loadRegisters
	b stop
dontDivide: 
	ldr r2, = mensaje_cancelarDivision
	bl printString
	b loadRegisters
	b stop

loadRegisters: 
    ldr r0, =numero1
    ldr r0, [r0]
    ldr r1, =numero2
    ldr r1, [r1]
    ldr r2, =operador
    ldr r2, [r2]
    b stop

	

stop:   wfi
