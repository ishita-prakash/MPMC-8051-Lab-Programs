;LCD connected to Port 2
;P2 = Data pin => P2.0 - P2.7 is D0 - D7
;P1.0 = RS, P1.1 = R/W, P1.2 = E
;38H = init. LCD 2 lines, 5x7 matrix
;0EH = display on, cursor on
;01 = clear LCD
;06 = shift cursor right
;84H = cursor at line 1, position 4

ORG 0000H
	
	SEND_COM:
	
		MOV DPTR, #MYCOM
		C1:CLR A
		   MOVC A, @ A+DPTR
		   JZ SEND_DATA
		   ACALL COMNWRT
		   ACALL DELAY
		   INC DPTR
		   SJMP C1
	
	SEND_DATA:
	
		MOV DPTR, #MYNAME
		D1:CLR A
		   MOVC A, @ A+DPTR
		   JZ HERE
		   ACALL DATAWRT
		   ACALL DELAY
		   INC DPTR
		   SJMP D1
		   
		HERE: SJMP HERE
	
	COMNWRT:
		
		MOV P2, A
		CLR P1.0
		CLR P1.1
		SETB P1.2
		ACALL DELAY
		CLR P1.2
		RET
	
	DATAWRT:
		
		MOV P2, A
		SETB P1.0
		CLR P1.1
		SETB P1.2
		ACALL DELAY
		CLR P1.2
		RET
	
	DELAY:
		
		MOV TMOD, #10H
		MOV TH1, #0F1H
		MOV TL1, #9EH
		SETB TR1
		AGAIN: JNB TF1, AGAIN
		CLR TR1
		CLR TF1
		RET
	
ORG 0300H
	MYCOM: DB 38H, 0EH, 01, 06, 84H, 0
	MYNAME: DB "ISHITA PRAKASH", 0
	END
