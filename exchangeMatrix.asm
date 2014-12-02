.model small
.stack
.data
	matrix db '1','2','3','4','5','6','7','8','9','1','2','3','4','5','6','7',
		   '8','9','1','2','3','4','5','6','7'
	dim equ	4 ;matrix dimension
	limit equ 16 ;limit of BX*dim
.code
.startup
	MOV BX,0	;row
	MOV SI,0	;column
	MOV DI,dim-1
	MOV CX,dim
exchange:
	CMP SI,DI ;in the case of dim%2!=0
	JE optim
	MOV AL, matrix[BX][SI]
	XCHG AL, matrix[BX][DI]
	MOV matrix[BX][SI], AL
optim:
	INC SI
	DEC DI
	ADD BX,dim
loop exchange
;print matrix
MOV BX,0
	loop_rows:
		MOV SI,0
			loop_columns:
				MOV DL,matrix[BX][SI]
				MOV AH,2h
				INT 21h
				
				MOV DL,' ' ;space
				MOV AH,2h
				INT 21h
				
				INC SI
				CMP SI,dim
			JB loop_columns
		
		MOV DL,10 ;new line
		MOV AH,2h
		INT 21h
		
		ADD BX,dim
		CMP BX,limit
	JB loop_rows
	
	mov ax,4c00h ;close
	int 21h
end