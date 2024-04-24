ORG 0000H
	
HERE: MOV P0, #55H
	MOV P1, #55H
	MOV P2, #55H
	ACALL DELAY
	MOV P0, #0AAH
	MOV P1, #0AAH
	MOV P2, #0AAH
	ACALL DELAY
	
	SJMP HERE
	
	DELAY: MOV TMOD, #20H
		   MOV TH1, #00H
		   SETB TR1
		   AGAIN: JNB TF1, AGAIN
		   CLR TR1
		   CLR TF1
		   RET
		   
		   END
