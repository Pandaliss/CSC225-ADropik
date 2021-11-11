.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near

.data

stringAddress	dword	?
string			byte	?
handle			dword	?
written			dword	?
numOfBytes		dword	?

.code

	push stringAddress
	call _PrintLine

	push 0
	call _ExitProcess@4


main PROC near

_main:


_PrintLine:

	; handle = GetStdHandle(-11)
	push -11
	call _GetStdHandle@4

	mov		handle, eax

	; WriteConsole(handle, &msg[0], 13, &written, 0)
	push 0
	push offset written
	push 13
	push offset string
	push handle
	call _WriteConsoleA@20
	

	

main ENDP
END