.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near
extern _ExitProcess@4: near
;extern _PrintLine


.data

readHandle		dword	?
handle			dword	?
written			dword	?

msg		byte	'Enter number 1: ', 10
msg2	byte	'Enter number 2: ', 10
result	byte	'The multiplication result is: ', 10

input				byte	256		DUP(00h)
input2				byte	256		DUP(00h)
read				byte	?
numofBytestoRead	dword	?
num1				dword	0
num2				dword	0
answer				dword	0
answer2				dword	0

.code

;												---------------------------
;												------WRITING SECTION------
;												---------------------------

WriteLine PROC near

	push	ebp							; Save the old base pointer
	mov		ebp,	esp					; Set new base pointer
	mov		ebx,	[ebp+8]				; Getting parameter that we want (string address)
	mov		ecx,	0
	mov		edi,	ebx					; storing original msg in edi becase we will be incrementing ebx to get amount of chars later

_counting:

	mov		al,		[ebx]
	cmp		al,		 10
	je		_writeLine
	
	inc		ecx
	inc		ebx
	jmp		_counting

_writeLine:

	push	-11
	call	_GetStdHandle@4
	mov		handle, eax

	push	0
	push	offset written
	push	ecx
	push	edi
	push	handle
	call	_WriteConsoleA@20
	pop		ebp
	ret		4

WriteLine ENDP
								
;												---------------------------
;												----WRITING SECTION END----
;												---------------------------


;												---------------------------
;												------READING SECTION------
;												---------------------------

ReadLine PROC near
	
	push	ebp							; Save the old base pointer
	mov		ebp,	esp					; Set new base pointer
	mov		ebx,	[ebp+8]				; Getting parameter that we want (string address)

	push	-10							
	call	_GetStdHandle@4

	mov		readHandle, eax

	push	0
	push	offset read
	push	7
	push	ebx
	push	readHandle
	call	_ReadConsoleA@20
	pop		ebp
	ret		4

ReadLine ENDP

;												---------------------------
;												----READING SECTION END----
;												---------------------------

atoi PROC near

	push	ebp							; Save the old base pointer
	mov		ebp,	esp					; Set new base pointer
	mov		ebx,	[ebp+8]				; Getting parameter that we want (string address)
	add		esp,	4
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
			;we get the number we are trying to represent (not sure if that has to be done in code). To convert the ascii value
			;to integer, we need to multiply each number by 10^x, x being how many digits there are. We have to start at the
			;furthest right number? Then we put into a new register

	mov		esi,	1				;set up for 10^x
	dec		ebx

_atoiLoop:
	
	mov		eax,	0
	cmp		ecx,	0
	je		_atoiLoopdone
	mov		al,		[ebx]			;taking the specific number at beginning of ebx and putting into smaller reg
	sub		al,		30h
	mul		esi
	mov		[ebp],	eax	
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


itoa PROC near

	
	ret		8

itoa ENDP

main PROC near

_main:
	
	push	offset msg
	call	WriteLine

	push	offset input
	call	ReadLine

	push	offset msg2
	call	WriteLine

	push	offset	input2
	call	ReadLine

	push	offset input
	call	atoi
	mov		num1,	eax	
	push	offset input2
	call	atoi
	mov		num2,	eax

	mov		eax,	num1
	mul		num2
	mov		answer,	eax

	push	offset result
	call	WriteLine

	push	offset	answer
	push	offset	answer2
	call	itoa

	push	0
	call	_ExitProcess@4

main ENDP
END