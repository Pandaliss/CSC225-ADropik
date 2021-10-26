.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near

.data

alphabet		byte	'a', 'b', 'c', 'd'		; this is array
outputHandle	dword	?
written			dword	?

.code


main PROC near

_main:

	; outputHandle = getStdHandle(-11)
	push	-11
	call	_GetStdHandle@4
	mov		outputHandle, eax

	mov		edx, offset written
	mov		ebx, offset alphabet

	mov		esi, 0								; need base of array

_loop:
	
	cmp		esi, 4
	jz		_exit
	mov		eax, ebx
	add		eax, esi
	add		esi, 1

	; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)
	push	0
	push	edx
	push	1
	push	eax
	push	outputHandle
	call	_WriteConsoleA@20
	jmp		_loop

_exit:

	push 0
	call _ExitProcess@4

main ENDP
END