.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near
extern _ExitProcess@4: near

.code 

atoi PROC near

	push	ebp						;Save the old base pointer
	mov		ebp,	esp				;Set new base pointer
	mov		ebx,	[ebp+8]			;Getting parameter that we want (string address)
	add		esp,	4				;making space on stack for variable 
	mov		ecx,	0				;Setting counter
	mov		edi,	ebx				;storing original input in edi becase we will be incrementing ebx to get num of nums later
	
_countingLoop:

	mov		al,		[ebx]			;Getting the single number from ebx and storing it into al 
	cmp		al,		0dh				;Comparing the current number to 0dh, which is a carriage return to check if we have made it to the end
	je		_atoi					;Go to atoi to do conversion if current num is equal to 0dh
	
	inc		ecx						;incrementing counter
	inc		ebx						;incrementing ebx to get to next num
	jmp		_countingLoop			;restarting loop

_atoi:

			;THOUGHT PROCESS HERE: if we start with 750, that is 37 35 30 in memory. If we subtract 30 from each of these numbers
			;we get the number we are trying to represent. To convert the ascii value to integer, we need to multiply each number by 10^x,
			;x being how many digits there are/which number spot we are on (100s, 10s, 1s, etc). We have to start at the furthest right number. Then we put into a new register

	mov		esi,	1				;set up for 10^x
	dec		ebx						;going back to the most right number
	mov		edx,	0
	mov		[ebp],	edx	

_atoiLoop:
	
	mov		eax,	0
	cmp		ecx,	0
	je		_atoiLoopdone
	mov		al,		[ebx]			;taking the specific number at beginning of ebx and putting into smaller reg
	sub		al,		30h
	mul		esi						;this does whatever is in eax * esi
	mov		edx,	[ebp]
	add		edx,	eax
	mov		[ebp],	edx				;moving the result of the multiplication onto the stack to store
	mov		eax,	10
	mul		esi
	mov		esi,	eax
	dec		ecx
	dec		ebx
	jmp		_atoiLoop

_atoiLoopdone:		;this loop is for if there is only 1 number

	mov		eax,	[ebp]
	mov		esp,	ebp
	pop		ebp
	ret		4

atoi ENDP

END