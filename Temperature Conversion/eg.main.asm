.386P

.model flat

extern _GetStdHandle@4:near
extern _ExitProcess@4: near
extern _WriteConsoleA@20:near
extern _ReadConsoleA@20:near

.data

fahrenheit					real8		?
celsius						real8		?
fahrenheitToCelsius			real8		0.5555555556
celsiusToFahrenheit			real8		1.8
int32Constant				dword		32


.code

;	C = (F - 32) * 5/9
;	F = (C * 9/5) + 32


main PROC near

_FahrenheitToCelsius:
	
	fld st(fahrenheit)
	fild int32Constant
	fsubp							; this will subtract int32 from fahrenheit
	fmulp

_main:

	fld st(fahrenheitToCelsius)
	jmp _FahrenheitToCelsius

	push 0
	call _ExitProcess@4

main ENDP
END