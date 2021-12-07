.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near
extern _ExitProcess@4: near

extern WriteLine:near
extern ReadLine:near
extern atoi:near
extern itoa:near

.data

msg		byte	'Enter number 1: ', 10
msg2	byte	'Enter number 2: ', 10
result	byte	'The multiplication result is: ', 10

input				byte	256		DUP(00h)
input2				byte	256		DUP(00h)

num1				dword	0
num2				dword	0
answer				dword	0
answer2				byte	256		DUP(00h)

.code

main PROC near

_main:
	
	push	offset msg
	call	WriteLine

	push	offset input
	call	ReadLine

	push	offset msg2
	call	WriteLine

	push	offset	input2
	call	ReadLine

	push	offset input
	call	atoi
	mov		num1,	eax	

	push	offset input2
	call	atoi
	mov		num2,	eax

	mov		eax,	num1
	mul		num2
	mov		answer,	eax

	push	offset result
	call	WriteLine

	push	offset	answer
	push	offset	answer2
	call	itoa

	push	eax
	call	WriteLine

	push	0
	call	_ExitProcess@4

main ENDP
END