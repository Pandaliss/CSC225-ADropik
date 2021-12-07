.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near
extern _ExitProcess@4: near

.code 

itoa PROC near

	push	ebp							;Save the old base pointer
	mov		ebp,	esp					;Set new base pointer
	mov		ebx,	[ebp+12]				;this will be the multiplication answer we got in int form
	mov		esi,	[ebp+8]			;this will be where we store the above answer in ascii form
	mov		eax,	[ebx]
	add		esi,	255
	mov		edi,	10
	mov		[esi],	edi
	dec		esi

_divideLoop:
	
	mov		edx,	0
	mov		ecx,	10
	div		ecx
	add		edx,	30h
	mov		[esi],	dl
	dec		esi
	cmp		eax,	0
	jne		_divideLoop

	mov		eax,	esi
	mov		esp,	ebp
	pop		ebp
	ret		8

itoa ENDP

END