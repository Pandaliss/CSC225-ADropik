.386P

.model flat

extern _ExitProcess@4: near

.data

number1		dword	10
number2		dword	20
number3		dword	30
number4		dword	40

.code




main PROC near

_main:
	; mov		eax, offset number1
	mov		eax,	number1
	mov		edx,	number2
	mov		edi,	number3
	mov		esi,	number4

	xchg	eax,	esi
	xchg	edx,	edi

	mov		number1, eax	; needs to be done to update what is in memory as well!
	mov		number2, edx
	mov		number3, edi
	mov		number4, esi

	push 0
	call _ExitProcess@4

main ENDP
END