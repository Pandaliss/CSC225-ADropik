.386P

.model flat

extern _ExitProcess@4: near

.data




.code




main PROC near

_main:
	
	mov eax, 5
	mov edx, 7
	add eax, edx

	push 0
	call _ExitProcess@4

main ENDP
END