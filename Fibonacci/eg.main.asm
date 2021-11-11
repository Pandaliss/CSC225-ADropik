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

	mov		ecx,	3			; ecx is counter register. We put 3 in there because that is where the for loop starts (i = 3)
	mov		eax,	5			; 5 can be changed to whatever number. EAX = n
	mov		edi,	prev
	mov		esi,	current
	mov		edx,	next

_loop:
	
	cmp		eax,	0			; lines 30-33 and 44-56 are fixes for the first 3 values of sequence fix
	je		_condition0
	cmp		eax,	3			
	jl		_condition1

	cmp		ecx,	eax			; loop condition checker
	jg		_exit				
	mov		edx,	esi			; this and next line are next = current + previous
	add		edx,	edi
	mov		edi,	esi			; previous = current
	mov		esi,	edx			; current = next
	inc		ecx					; incrementing i in for loop
	jmp		_loop				; restarting loop

_condition0:
	
	mov		eax,	0
	mov		next,	eax
	push	0
	call _ExitProcess@4

_condition1:

	mov		eax,	1
	mov		next,	eax
	push	0
	call _ExitProcess@4

_exit:
	
	mov		eax,	edx				; getting next and putting into eax for value checking
	mov		next,	eax				; writing to memory
	push	0
	call _ExitProcess@4

main ENDP
END