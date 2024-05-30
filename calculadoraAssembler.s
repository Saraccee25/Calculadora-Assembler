.data
numero1:	.word 10
numero2:	.word -9
operador:	.word 3
cadenaSuma:	.asciz "%d sumado con %d es igual a: %d"
cadenaResta:	.asciz "%d restado con %d es igual a: %d"
cadenaMul:	.asciz "%d multiplicado con %d es igual a: %d"
cadenaDiv:	.asciz "%d dividido entre %d es igual a: %d y tiene residuo %d"
mensajeDiv:	.asciz "No se puede dividir por 0"

		.text
main:		ldr r0, =numero1
		ldr r0, [r0]
		ldr r1, =numero2
		ldr r1, [r1]
		ldr r2, =operador
		ldr r2, [r2]
		cmp r2, #1
		beq suma
		cmp r2, #2
		beq resta
		cmp r2, #3
		beq multiplicacion
		cmp r2, #4
		beq division
		b stop
		
suma:		mov r4, r0
		mov r5, r1
		add r6, r4, r5
		sub sp, sp, #8
		str r6, [sp, #4]
		str r5, [sp]
		mov r3, r4
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaSuma
		bl printf 
		add sp, sp, #8
		b stop

resta:		mov r4, r0
		mov r5, r1
		sub r6, r4, r5
		sub sp, sp, #8
		str r6, [sp, #4]
		str r5, [sp]
		mov r3, r4
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaResta
		bl printf 
		add sp, sp, #8
		b stop

multiplicacion:	mov r4, r0
		mov r5, r1
		mul r1, r4, r1
		sub sp, sp, #8
		str r1, [sp, #4]
		str r5, [sp]
		mov r3, r4
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaMul
		bl printf 
		add sp, sp, #8
		b stop

division:
		mov r4, r0
		mov r5, r1
		cmp r5, #0
		beq stopDiv
		bl sdivide
		sub sp, sp, #12
		str r1, [sp, #8]
		str r0, [sp, #4]
		str r5, [sp]
		mov r3, r4
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaDiv
		bl printf 
		add sp, sp, #12
		b stop

stopDiv:	mov r0, #0
		mov r1, #0
		ldr r2, =mensajeDiv
		bl printf 
		wfi

stop: 		wfi
