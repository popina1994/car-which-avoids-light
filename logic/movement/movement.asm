_modeChange:
;movement.c,13 :: 		void modeChange(int newMode)
; newMode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; newMode end address is: 0 (R0)
; newMode start address is: 0 (R0)
;movement.c,15 :: 		moveMode = newMode;
MOVW	R1, #lo_addr(_moveMode+0)
MOVT	R1, #hi_addr(_moveMode+0)
STRH	R0, [R1, #0]
;movement.c,16 :: 		isStarted = false;
MOVS	R2, #0
MOVW	R1, #lo_addr(_isStarted+0)
MOVT	R1, #hi_addr(_isStarted+0)
STRB	R2, [R1, #0]
;movement.c,17 :: 		switch (newMode)
IT	AL
BAL	L_modeChange0
; newMode end address is: 0 (R0)
;movement.c,19 :: 		case MOVE_MODE_FORWARD:
L_modeChange2:
;movement.c,20 :: 		stepCnt = MAX_MOVE_BACK;
MOVW	R2, #50
SXTH	R2, R2
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,21 :: 		break;
IT	AL
BAL	L_modeChange1
;movement.c,22 :: 		case MOVE_MODE_CIRCLE:
L_modeChange3:
;movement.c,23 :: 		stepCnt = MAX_MOVE_CIRCLE;
MOVW	R2, #440
SXTH	R2, R2
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,24 :: 		resetLightMaxPar();
BL	_resetLightMaxPar+0
;movement.c,25 :: 		break;
IT	AL
BAL	L_modeChange1
;movement.c,26 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_modeChange4:
;movement.c,28 :: 		stepCntToDark = MAX_MOVE_CIRCLE - stepCntToDark;
MOVW	R2, #lo_addr(_stepCntToDark+0)
MOVT	R2, #hi_addr(_stepCntToDark+0)
LDRSH	R1, [R2, #0]
RSB	R1, R1, #440
SXTH	R1, R1
STRH	R1, [R2, #0]
;movement.c,30 :: 		if ( (double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 0.5f)
VMOV	S1, R1
VCVT.F32	#1, S1, S1
MOVW	R1, #0
MOVT	R1, #17372
VMOV	S0, R1
VDIV.F32	S1, S1, S0
VMOV.F32	S0, #0.5
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_modeChange5
;movement.c,32 :: 		stepCnt = MAX_MOVE_CIRCLE_HALF + stepCntToDark;
MOVW	R1, #lo_addr(_stepCntToDark+0)
MOVT	R1, #hi_addr(_stepCntToDark+0)
LDRSH	R1, [R1, #0]
ADDW	R2, R1, #220
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,33 :: 		}
IT	AL
BAL	L_modeChange6
L_modeChange5:
;movement.c,34 :: 		else if ((double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 1f)
MOVW	R1, #lo_addr(_stepCntToDark+0)
MOVT	R1, #hi_addr(_stepCntToDark+0)
LDRSH	R1, [R1, #0]
VMOV	S1, R1
VCVT.F32	#1, S1, S1
MOVW	R1, #0
MOVT	R1, #17372
VMOV	S0, R1
VDIV.F32	S1, S1, S0
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_modeChange7
;movement.c,36 :: 		stepCnt = stepCntToDark - MAX_MOVE_CIRCLE_HALF;
MOVW	R1, #lo_addr(_stepCntToDark+0)
MOVT	R1, #hi_addr(_stepCntToDark+0)
LDRSH	R1, [R1, #0]
SUBW	R2, R1, #220
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,37 :: 		}
L_modeChange7:
L_modeChange6:
;movement.c,38 :: 		break;
IT	AL
BAL	L_modeChange1
;movement.c,39 :: 		}
L_modeChange0:
; newMode start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_modeChange2
CMP	R0, #1
IT	EQ
BEQ	L_modeChange3
CMP	R0, #2
IT	EQ
BEQ	L_modeChange4
; newMode end address is: 0 (R0)
L_modeChange1:
;movement.c,40 :: 		}
L_end_modeChange:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _modeChange
_modeStart:
;movement.c,42 :: 		void modeStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;movement.c,44 :: 		isStarted = true;
MOVS	R1, #1
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
STRB	R1, [R0, #0]
;movement.c,45 :: 		switch (moveMode)
IT	AL
BAL	L_modeStart8
;movement.c,47 :: 		case MOVE_MODE_FORWARD:
L_modeStart10:
;movement.c,48 :: 		wheelRightStart();
BL	_wheelRightStart+0
;movement.c,49 :: 		wheelLeftStart();
BL	_wheelLeftStart+0
;movement.c,50 :: 		break;
IT	AL
BAL	L_modeStart9
;movement.c,51 :: 		case MOVE_MODE_CIRCLE:
L_modeStart11:
;movement.c,52 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;movement.c,53 :: 		wheelRightStart();
BL	_wheelRightStart+0
;movement.c,54 :: 		break;
IT	AL
BAL	L_modeStart9
;movement.c,55 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_modeStart12:
;movement.c,56 :: 		wheelRightStart();
BL	_wheelRightStart+0
;movement.c,57 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;movement.c,58 :: 		break;
IT	AL
BAL	L_modeStart9
;movement.c,59 :: 		}
L_modeStart8:
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_modeStart10
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_modeStart11
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_modeStart12
L_modeStart9:
;movement.c,60 :: 		}
L_end_modeStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _modeStart
_timerTicked:
;movement.c,62 :: 		void timerTicked()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;movement.c,64 :: 		if (isPWMInitialized)
MOVW	R0, #lo_addr(_isPWMInitialized+0)
MOVT	R0, #hi_addr(_isPWMInitialized+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timerTicked13
;movement.c,66 :: 		if (!isStarted)
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timerTicked14
;movement.c,68 :: 		modeStart();
BL	_modeStart+0
;movement.c,69 :: 		}
L_timerTicked14:
;movement.c,70 :: 		if (MOVE_MODE_CIRCLE == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timerTicked15
;movement.c,72 :: 		if (stepCnt > 0)
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_timerTicked16
;movement.c,74 :: 		stepCnt --;
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;movement.c,75 :: 		updateLightArray();
BL	_updateLightArray+0
;movement.c,76 :: 		lightValCalcAndUpdate();
BL	_lightValCalcAndUpdate+0
;movement.c,77 :: 		if (lightValueCurMax > lightValueMax)
MOVW	R0, #lo_addr(_lightValueMax+0)
MOVT	R0, #hi_addr(_lightValueMax+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
LDRH	R0, [R0, #0]
CMP	R0, R1
IT	LS
BLS	L_timerTicked17
;movement.c,79 :: 		lightValueMax = lightValueCurMax;
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_lightValueMax+0)
MOVT	R0, #hi_addr(_lightValueMax+0)
STRH	R1, [R0, #0]
;movement.c,80 :: 		stepCntToDark = stepCnt;
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_stepCntToDark+0)
MOVT	R0, #hi_addr(_stepCntToDark+0)
STRH	R1, [R0, #0]
;movement.c,81 :: 		}
L_timerTicked17:
;movement.c,82 :: 		}
IT	AL
BAL	L_timerTicked18
L_timerTicked16:
;movement.c,85 :: 		modeChange(MOVE_MODE_SEARCH_LIGHT);
MOVW	R0, #2
SXTH	R0, R0
BL	_modeChange+0
;movement.c,86 :: 		}
L_timerTicked18:
;movement.c,87 :: 		}
IT	AL
BAL	L_timerTicked19
L_timerTicked15:
;movement.c,88 :: 		else if (MOVE_MODE_FORWARD == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timerTicked20
;movement.c,90 :: 		if (stepCnt > 0)
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_timerTicked21
;movement.c,92 :: 		stepCnt --;
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;movement.c,93 :: 		}
IT	AL
BAL	L_timerTicked22
L_timerTicked21:
;movement.c,96 :: 		modeChange(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_modeChange+0
;movement.c,97 :: 		}
L_timerTicked22:
;movement.c,98 :: 		}
IT	AL
BAL	L_timerTicked23
L_timerTicked20:
;movement.c,99 :: 		else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_timerTicked24
;movement.c,101 :: 		if (stepCnt > 0)
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_timerTicked25
;movement.c,103 :: 		stepCnt --;
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;movement.c,104 :: 		}
IT	AL
BAL	L_timerTicked26
L_timerTicked25:
;movement.c,107 :: 		modeChange(MOVE_MODE_FORWARD);
MOVW	R0, #0
SXTH	R0, R0
BL	_modeChange+0
;movement.c,108 :: 		}
L_timerTicked26:
;movement.c,109 :: 		}
L_timerTicked24:
L_timerTicked23:
L_timerTicked19:
;movement.c,110 :: 		}
L_timerTicked13:
;movement.c,115 :: 		if (isBluetoothReadyForTransmission())
BL	_isBluetoothReadyForTransmission+0
CMP	R0, #0
IT	EQ
BEQ	L_timerTicked27
;movement.c,117 :: 		stringSendViaBluetooth("\n\rlightValueDetected: ");
MOVW	R0, #lo_addr(?lstr_1_movement+0)
MOVT	R0, #hi_addr(?lstr_1_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,118 :: 		intSendIntViaBluetooth(lightValueDetected);
MOVW	R0, #lo_addr(_lightValueDetected+0)
MOVT	R0, #hi_addr(_lightValueDetected+0)
LDRH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,120 :: 		stringSendViaBluetooth("CurLightValue: ");
MOVW	R0, #lo_addr(?lstr_2_movement+0)
MOVT	R0, #hi_addr(?lstr_2_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,121 :: 		intSendIntViaBluetooth(lightValueCurMax);
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
LDRH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,123 :: 		stringSendViaBluetooth("MaxLightValue: ");
MOVW	R0, #lo_addr(?lstr_3_movement+0)
MOVT	R0, #hi_addr(?lstr_3_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,124 :: 		intSendIntViaBluetooth(lightValueMax);
MOVW	R0, #lo_addr(_lightValueMax+0)
MOVT	R0, #hi_addr(_lightValueMax+0)
LDRH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,126 :: 		stringSendViaBluetooth("stepCnt: ");
MOVW	R0, #lo_addr(?lstr_4_movement+0)
MOVT	R0, #hi_addr(?lstr_4_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,127 :: 		intSendIntViaBluetooth(stepCnt);
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,129 :: 		stringSendViaBluetooth("stepCntToDark: ");
MOVW	R0, #lo_addr(?lstr_5_movement+0)
MOVT	R0, #hi_addr(?lstr_5_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,130 :: 		intSendIntViaBluetooth(stepCntToDark);
MOVW	R0, #lo_addr(_stepCntToDark+0)
MOVT	R0, #hi_addr(_stepCntToDark+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,132 :: 		stringSendViaBluetooth("Move:");
MOVW	R0, #lo_addr(?lstr_6_movement+0)
MOVT	R0, #hi_addr(?lstr_6_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,133 :: 		switch (moveMode)
IT	AL
BAL	L_timerTicked28
;movement.c,135 :: 		case MOVE_MODE_FORWARD:
L_timerTicked30:
;movement.c,136 :: 		stringSendViaBluetooth("FORWARD");
MOVW	R0, #lo_addr(?lstr_7_movement+0)
MOVT	R0, #hi_addr(?lstr_7_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,137 :: 		break;
IT	AL
BAL	L_timerTicked29
;movement.c,138 :: 		case MOVE_MODE_CIRCLE:
L_timerTicked31:
;movement.c,139 :: 		stringSendViaBluetooth("CIRCLE");
MOVW	R0, #lo_addr(?lstr_8_movement+0)
MOVT	R0, #hi_addr(?lstr_8_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,140 :: 		break;
IT	AL
BAL	L_timerTicked29
;movement.c,141 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_timerTicked32:
;movement.c,142 :: 		stringSendViaBluetooth("SEARCH_LIGHT");
MOVW	R0, #lo_addr(?lstr_9_movement+0)
MOVT	R0, #hi_addr(?lstr_9_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,143 :: 		break;
IT	AL
BAL	L_timerTicked29
;movement.c,144 :: 		default:
L_timerTicked33:
;movement.c,145 :: 		stringSendViaBluetooth("UNINITIALIZED");
MOVW	R0, #lo_addr(?lstr_10_movement+0)
MOVT	R0, #hi_addr(?lstr_10_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,146 :: 		}
IT	AL
BAL	L_timerTicked29
L_timerTicked28:
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timerTicked30
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_timerTicked31
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_timerTicked32
IT	AL
BAL	L_timerTicked33
L_timerTicked29:
;movement.c,147 :: 		intSendIntViaBluetooth(-1);
MOVW	R0, #65535
SXTH	R0, R0
BL	_intSendIntViaBluetooth+0
;movement.c,148 :: 		}
L_timerTicked27:
;movement.c,150 :: 		}
L_end_timerTicked:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _timerTicked
_detectionStart:
;movement.c,153 :: 		void detectionStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;movement.c,155 :: 		modeChange(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_modeChange+0
;movement.c,156 :: 		isPWMInitialized = true;
MOVS	R1, #1
MOVW	R0, #lo_addr(_isPWMInitialized+0)
MOVT	R0, #hi_addr(_isPWMInitialized+0)
STRB	R1, [R0, #0]
;movement.c,157 :: 		}
L_end_detectionStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _detectionStart
