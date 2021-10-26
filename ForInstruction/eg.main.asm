.386P

.model flat

extern _ExitProcess@4: near

.data




.code




main PROC near

_main:

	mov ecx, 10
	mov eax, 0

_loop:
	
	cmp ecx, 0
	jz _exit
	add eax, ecx
	add ecx, -1
	; jnz	_loop
	jmp _loop

_exit:
	
	push 0
	call _ExitProcess@4

main ENDP
END