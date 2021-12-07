.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near
extern _ExitProcess@4: near

.data

	readHandle		dword	?
	read			byte	?

.code 

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
	mov		esp,	ebp
	pop		ebp
	ret		4

ReadLine ENDP

END