.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near
extern _ExitProcess@4: near
; extern _PrintLine


.data

readHandle			dword	?
handle				dword	?
written				dword	?

msg		byte	'Enter number 1: ', 10
msg2	byte	'Enter number 2: ', 10
result	byte	'The multiplcation result is: ', 10

input				byte	256 DUP(00h)
read				byte	?
numofBytestoRead	dword	?

.code

WriteLine PROC near

_WriteLine:

	push ebp						; Save the old base pointer
	mov ebp, esp					; Set new base pointer

	; handle = GetStdHandle(-11)
	push	-11
	call	_GetStdHandle@4

	mov		handle, eax

	; WriteConsole(handle, &msg[0], 17, &written, 0)
	push	0
	push	offset written
	push	17
	push	offset msg
	push	handle
	call	_WriteConsoleA@20
	pop		ebp
	ret

WriteLine ENDP

WriteLine2 PROC near

	push ebp						; Save the old base pointer
	mov ebp, esp					; Set new base pointer

	; handle = GetStdHandle(-11)
	push	-11
	call	_GetStdHandle@4

	mov		handle, eax

	; WriteConsole(handle, &msg[0], 17, &written, 0)
	push	0
	push	offset written
	push	17
	push	offset msg2
	push	handle
	call	_WriteConsoleA@20
	pop		ebp
	ret

WriteLine2 ENDP

ResultLine PROC near

	push ebp						; Save the old base pointer
	mov ebp, esp					; Set new base pointer

	; handle = GetStdHandle(-11)
	push	-11
	call	_GetStdHandle@4

	mov		handle, eax

	; WriteConsole(handle, &msg[0], 17, &written, 0)
	push	0
	push	offset written
	push	30
	push	offset result
	push	handle
	call	_WriteConsoleA@20
	pop		ebp
	ret

ResultLine ENDP

ReadLine PROC near
	
	push ebp						; Save the old base pointer
	mov ebp, esp					; Set new base pointer
	mov ebx, [ebp+8]				; Getting parameter that we want (string address)

_Reading:

	push -10							
	call _GetStdHandle@4

	mov		readHandle, eax

	; ReadConsole (handle, &msg[0], numofCharsToRead, )
	push	0
	push	offset read
	push	7
	push	offset input
	push	readHandle
	call	_ReadConsoleA@20
	pop		ebp
	ret

ReadLine ENDP

ReadLine2 PROC near
	
	push ebp						; Save the old base pointer
	mov ebp, esp					; Set new base pointer
	mov ebx, [ebp+8]				; Getting parameter that we want (string address)

	push	-10							
	call	_GetStdHandle@4
	mov		readHandle, eax

	; ReadConsole (handle, &msg[0], numofCharsToRead, )
	push	0
	push	offset read
	push	7
	push	offset input
	push	readHandle
	call	_ReadConsoleA@20
	pop		ebp
	ret

ReadLine2 ENDP

atoi PROC near



atoi ENDP


itoa PROC near



itoa ENDP

main PROC near

_main:
	
	push offset msg
	call WriteLine

	call ReadLine

	push offset msg2
	call WriteLine2

	call ReadLine2

	call ResultLine

	push 0
	call _ExitProcess@4

main ENDP
END