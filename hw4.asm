TITLE	HW4	輸入3字元字串，輸出找到該字串幾次
STACK	  SEGMENT	PARA	STACK	'Stack'
	DB	64 DUP(0)
STACK	  ENDS
;---------------------------------------------------
DATASEG   SEGMENT	PARA	'Data'
TEXT1	DB	'Up to this chapter, most of the programs have executed in a straight line, with one instruction '    ;課本內文
TEXT2	DB	'sequentially following another. Seldom, however, is a programmable problem that simple.'       ;
TEXT3	DB	'Instead, most programs consist of various tests to determine which of several actions '
TEXT4	DB	'to take and a number of loops in which a series of steps repeats until a specific requirement '
TEXT5	DB	'is reached. A common practice, for example, is to test whether a program is supposed to end execution.',0AH

LAST	DB	0AH
STR_A	DB	'INPUT STRING(3Chars):', '$'

MAX_A	DB	4
ACT_A	DB	?
DATA_A	DB  4 DUP('0')

NUM		DB	'output:'
SUM		DB	30H,'$'

DATASEG	ENDS
;---------------------------------------------------
CODESEG	  SEGMENT	PARA	'Code'
MAIN	PROC 	  FAR
	ASSUME SS:STACK,CS:CODESEG,DS:DATASEG,ES:DATASEG
	MOV		AX, DATASEG	;取出 .data 的segment，存入 AX
	MOV		DS,AX		;
	MOV		ES,AX		;

	MOV		AH,09H		;輸出字串到螢幕，要顯示的字串必須以「$」結束
	LEA		DX,STR_A	;顯示字串:INPUT STRING(3Chars):
	INT		21H			;INT意思:呼叫中斷副程式

	MOV		AH,0AH		;鍵盤輸入function
	LEA		DX,MAX_A	;
	INT		21H			;INT意思:呼叫中斷副程式

	MOV 	DL,0AH		;換行
	MOV 	AH,02H		;
	INT 	21H			;


	LEA		SI,TEXT1	;SI=TEXT1的offset
	LEA		SP,TEXT1	;SP=TEXT1的offset

A10:	
	MOV		SI,SP		;SI=SP
	LEA		DI,LAST		;判斷是否到尾
	CMPSB				;比較、DI++、SI++
	JE		A30			;若SI(要比較的位)為LAST，跳到A30輸出結果
	DEC		SI			;SI--

	MOV		CX,03		;迴圈三次檢查三個字都相同
	LEA		DI,DATA_A	;DI=DATA_A的offset
	REPE	CMPSB		;REPE	CX=CX-1,if CX!=0 and ZF=1 then repeat

	JNE		A20			;第三個字元不等於則跳到A20	
	INC		SUM			;總次數+1

A20:	
	INC		SP			;SP++  做本文下三個字的比較
	JMP		A10			;離開迴圈、輸出結果

A30:
	MOV		AH,09H	;輸出字串到螢幕，要顯示的字串必須以「$」結束
	LEA		DX,NUM	;從NUM開始顯示字串
	INT		21H		;INT意思:呼叫中斷副程式

	MOV		AX,4C00H	;結束程式
	INT		21H 		;INT意思:呼叫中斷副程式
MAIN	ENDP
CODESEG	ENDS
	END	  MAIN
