print_hex:
	pusha

	mov cx, 0 ; set counter to 0

	print_hex_char:
		cmp cx, 4         ; run loop 4 times
		je print_hex_done

		mov bx, dx
		and bx, 0x000f    ; get the lowest 4 bits (single hex char)
		add bx, HEX_CHARS ; make bx point to the actual hex char

		mov ax, [bx]
		mov bx, HEX_OUT
		add bx, 2       ; skip first 2 characters (0x)
		add bx, 3 
		sub bx, cx			; char index to replace = 2+(3-i)
		mov [bx], al		; replace character in HEX_OUT

		shr dx, 4 ; work on the next hex char
		add cx, 1 ; increment counter
		jmp print_hex_char

	print_hex_done:
		mov bx, HEX_OUT
		call print_string
		popa
		ret	

HEX_OUT: db '0x0000',0

HEX_CHARS:
	db '0123456789abcdef'
