.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near
extern _ExitProcess@4: near

.data

	handle			dword	?
	written			dword	?

.code 

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
	mov		esp,	ebp
	pop		ebp
	ret		4

WriteLine ENDP

END