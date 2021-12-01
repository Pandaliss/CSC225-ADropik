.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near

.data

string			byte	'Test12345', 10
handle			dword	?
written			dword	?
numOfBytes		dword	?

.code

PrintLine PROC near					; Defines procedure


	push ebp						; Save the old base pointer
	mov ebp, esp					; Set new base pointer
	mov ebx, [ebp+8]				; Getting parameter that we want (string address)

	mov ecx, 0
	
_Counting:

	mov al, [ebx]
	cmp	al, 10
	je	_PrintLine
	
	inc ecx
	inc ebx
	jmp _Counting

_PrintLine:

	; handle = GetStdHandle(-11)
	push -11							
	call _GetStdHandle@4

	mov		handle, eax

	; WriteConsole(handle, &msg[0], numOfChars, &written, 0)
	push 0
	push offset written
	push ecx
	push offset string
	push handle
	call _WriteConsoleA@20
	mov eax, written			; getting the return from procedure 
	pop ebp
	ret 4

PrintLine ENDP	

main PROC near

_main:

	push offset string
	call PrintLine
	
	push 0
	call _ExitProcess@4

main ENDP

END