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
	mov		eax,	6				; 5 can be changed to whatever number. EAX = n
	mov		edi,	prev
	mov		esi,	current
	mov		edx,	next

	cmp		eax,	0				; Need to add conditions to fix edge cases when counter fails with negative numbers and 0
	je		_condition0
	cmp		eax,	3			
	jl		_condition1
	cmp		eax,	3
	je		_condition2
	sub		eax,	ecx				; Subtracting ECX from EAX so we know how many iterations we need to do and storing it into ecx. This is because the loop starts at 3
	add		eax,	1				; have to add 1 to make up for edge cases
	mov		ecx,	eax				; updating ecx so counter is correct for loop instruction

_loop: 
										
	mov		edx,	esi				; this and next line are next = current + previous
	add		edx,	edi
	mov		edi,	esi				; previous = current
	mov		esi,	edx				; current = next
	loop	_loop			
	jmp		_exit

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

_condition2:

	mov		eax,	2
	mov		next,	eax
	push	0
	call _ExitProcess@4

_exit:
	
	mov		eax,	edx				; getting next and putting into eax for value checking
	push 0
	call _ExitProcess@4

main ENDP
END