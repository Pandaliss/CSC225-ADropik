.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near

.data

prev		dword	1
current		dword	1
next		dword	0

.code


main PROC near

_main:

	mov		ecx,	3				; ecx is counter register. We put 3 in there because that is where the for loop starts (i = 3)
	mov		eax,	5				; 5 can be changed to whatever number. EAX = n
	mov		edi,	prev
	mov		esi,	current
	mov		edx,	next

_loop:
	
	sub		ecx,	eax 			; Subtracting ECX from EAX so we know how many iterations we need to do and storing it into ecx. This is because the loop starts at 3 
										
	mov		edx,	esi				; this and next line are next = current + previous
	add		edx,	edi
	mov		edi,	esi				; previous = current
	mov		esi,	edx				; current = next
	loop	_loop					; this will decrement ecx and jumps back up if the ecx is not 0

_exit:
	
	mov		eax,	edx				; getting next and putting into eax for value checking
	push 0
	call _ExitProcess@4

main ENDP
END