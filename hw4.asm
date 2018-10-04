TITLE	HW4	��J3�r���r��A��X���Ӧr��X��
STACK	  SEGMENT	PARA	STACK	'Stack'
	DB	64 DUP(0)
STACK	  ENDS
;---------------------------------------------------
DATASEG   SEGMENT	PARA	'Data'
TEXT1	DB	'Up to this chapter, most of the programs have executed in a straight line, with one instruction '    ;�ҥ�����
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
	MOV		AX, DATASEG	;���X .data ��segment�A�s�J AX
	MOV		DS,AX		;
	MOV		ES,AX		;

	MOV		AH,09H		;��X�r���ù��A�n��ܪ��r�ꥲ���H�u$�v����
	LEA		DX,STR_A	;��ܦr��:INPUT STRING(3Chars):
	INT		21H			;INT�N��:�I�s���_�Ƶ{��

	MOV		AH,0AH		;��L��Jfunction
	LEA		DX,MAX_A	;
	INT		21H			;INT�N��:�I�s���_�Ƶ{��

	MOV 	DL,0AH		;����
	MOV 	AH,02H		;
	INT 	21H			;


	LEA		SI,TEXT1	;SI=TEXT1��offset
	LEA		SP,TEXT1	;SP=TEXT1��offset

A10:	
	MOV		SI,SP		;SI=SP
	LEA		DI,LAST		;�P�_�O�_���
	CMPSB				;����BDI++�BSI++
	JE		A30			;�YSI(�n�������)��LAST�A����A30��X���G
	DEC		SI			;SI--

	MOV		CX,03		;�j��T���ˬd�T�Ӧr���ۦP
	LEA		DI,DATA_A	;DI=DATA_A��offset
	REPE	CMPSB		;REPE	CX=CX-1,if CX!=0 and ZF=1 then repeat

	JNE		A20			;�ĤT�Ӧr��������h����A20	
	INC		SUM			;�`����+1

A20:	
	INC		SP			;SP++  ������U�T�Ӧr�����
	JMP		A10			;���}�j��B��X���G

A30:
	MOV		AH,09H	;��X�r���ù��A�n��ܪ��r�ꥲ���H�u$�v����
	LEA		DX,NUM	;�qNUM�}�l��ܦr��
	INT		21H		;INT�N��:�I�s���_�Ƶ{��

	MOV		AX,4C00H	;�����{��
	INT		21H 		;INT�N��:�I�s���_�Ƶ{��
MAIN	ENDP
CODESEG	ENDS
	END	  MAIN
