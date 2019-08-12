print_string:
	pusha

	print_char:
		mov ax, [bx]

		cmp al, 0            ; check for null
		je print_string_done ; stop loop if null

		mov ah, 0x0e
		int 0x10

		add bx, 0x01   ; advance by 1 char
		jmp print_char

	print_string_done:
		popa
		ret
