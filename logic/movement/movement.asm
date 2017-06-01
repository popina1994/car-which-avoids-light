_modeChange:
;movement.c,16 :: 		void modeChange(int newMode)
; newMode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; newMode end address is: 0 (R0)
; newMode start address is: 0 (R0)
;movement.c,18 :: 		moveMode = newMode;
MOVW	R1, #lo_addr(_moveMode+0)
MOVT	R1, #hi_addr(_moveMode+0)
STRH	R0, [R1, #0]
;movement.c,19 :: 		isStarted = false;
MOVS	R2, #0
MOVW	R1, #lo_addr(_isStarted+0)
MOVT	R1, #hi_addr(_isStarted+0)
STRB	R2, [R1, #0]
;movement.c,20 :: 		switch (newMode)
IT	AL
BAL	L_modeChange0
; newMode end address is: 0 (R0)
;movement.c,22 :: 		case MOVE_MODE_FORWARD:
L_modeChange2:
;movement.c,23 :: 		stepCnt = MAX_MOVE_BACK;
MOVW	R2, #50
SXTH	R2, R2
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,24 :: 		break;
IT	AL
BAL	L_modeChange1
;movement.c,25 :: 		case MOVE_MODE_CIRCLE:
L_modeChange3:
;movement.c,26 :: 		stepCnt = MAX_MOVE_CIRCLE;
MOVW	R2, #440
SXTH	R2, R2
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,27 :: 		resetLightMaxPar();
BL	_resetLightMaxPar+0
;movement.c,28 :: 		break;
IT	AL
BAL	L_modeChange1
;movement.c,29 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_modeChange4:
;movement.c,31 :: 		stepCntToDark = MAX_MOVE_CIRCLE - stepCntToDark;
MOVW	R2, #lo_addr(_stepCntToDark+0)
MOVT	R2, #hi_addr(_stepCntToDark+0)
LDRSH	R1, [R2, #0]
RSB	R1, R1, #440
SXTH	R1, R1
STRH	R1, [R2, #0]
;movement.c,33 :: 		if ( (double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 0.5f)
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
;movement.c,35 :: 		stepCnt = MAX_MOVE_CIRCLE_HALF + stepCntToDark;
MOVW	R1, #lo_addr(_stepCntToDark+0)
MOVT	R1, #hi_addr(_stepCntToDark+0)
LDRSH	R1, [R1, #0]
ADDW	R2, R1, #220
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,36 :: 		}
IT	AL
BAL	L_modeChange6
L_modeChange5:
;movement.c,37 :: 		else if ((double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 1f)
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
;movement.c,39 :: 		stepCnt = stepCntToDark - MAX_MOVE_CIRCLE_HALF;
MOVW	R1, #lo_addr(_stepCntToDark+0)
MOVT	R1, #hi_addr(_stepCntToDark+0)
LDRSH	R1, [R1, #0]
SUBW	R2, R1, #220
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
STRH	R2, [R1, #0]
;movement.c,40 :: 		}
L_modeChange7:
L_modeChange6:
;movement.c,41 :: 		break;
IT	AL
BAL	L_modeChange1
;movement.c,42 :: 		}
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
;movement.c,43 :: 		}
L_end_modeChange:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _modeChange
_modeStart:
;movement.c,45 :: 		void modeStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;movement.c,47 :: 		isStarted = true;
MOVS	R1, #1
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
STRB	R1, [R0, #0]
;movement.c,48 :: 		switch (moveMode)
IT	AL
BAL	L_modeStart8
;movement.c,50 :: 		case MOVE_MODE_FORWARD:
L_modeStart10:
;movement.c,51 :: 		wheelRightStart();
BL	_wheelRightStart+0
;movement.c,52 :: 		wheelLeftStart();
BL	_wheelLeftStart+0
;movement.c,53 :: 		break;
IT	AL
BAL	L_modeStart9
;movement.c,54 :: 		case MOVE_MODE_CIRCLE:
L_modeStart11:
;movement.c,55 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;movement.c,56 :: 		wheelRightStart();
BL	_wheelRightStart+0
;movement.c,57 :: 		break;
IT	AL
BAL	L_modeStart9
;movement.c,58 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_modeStart12:
;movement.c,59 :: 		wheelRightStart();
BL	_wheelRightStart+0
;movement.c,60 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;movement.c,61 :: 		break;
IT	AL
BAL	L_modeStart9
;movement.c,62 :: 		}
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
;movement.c,63 :: 		}
L_end_modeStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _modeStart
_interruptTimer3:
;movement.c,66 :: 		void interruptTimer3() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;movement.c,68 :: 		TIM3_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;movement.c,70 :: 		if (isPWMInitialized)
MOVW	R0, #lo_addr(_isPWMInitialized+0)
MOVT	R0, #hi_addr(_isPWMInitialized+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer313
;movement.c,72 :: 		if (!isStarted )
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer314
;movement.c,74 :: 		modeStart();
BL	_modeStart+0
;movement.c,75 :: 		}
L_interruptTimer314:
;movement.c,76 :: 		if (MOVE_MODE_CIRCLE == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interruptTimer315
;movement.c,78 :: 		if (stepCnt > 0)
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer316
;movement.c,80 :: 		stepCnt --;
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;movement.c,81 :: 		updateLightArray();
BL	_updateLightArray+0
;movement.c,82 :: 		lightValCalcAndUpdate();
BL	_lightValCalcAndUpdate+0
;movement.c,83 :: 		if (lightValueCurMax > lightValueMax)
MOVW	R0, #lo_addr(_lightValueMax+0)
MOVT	R0, #hi_addr(_lightValueMax+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
LDRH	R0, [R0, #0]
CMP	R0, R1
IT	LS
BLS	L_interruptTimer317
;movement.c,85 :: 		lightValueMax = lightValueCurMax;
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_lightValueMax+0)
MOVT	R0, #hi_addr(_lightValueMax+0)
STRH	R1, [R0, #0]
;movement.c,86 :: 		stepCntToDark = stepCnt;
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_stepCntToDark+0)
MOVT	R0, #hi_addr(_stepCntToDark+0)
STRH	R1, [R0, #0]
;movement.c,87 :: 		}
L_interruptTimer317:
;movement.c,88 :: 		}
IT	AL
BAL	L_interruptTimer318
L_interruptTimer316:
;movement.c,91 :: 		modeChange(MOVE_MODE_SEARCH_LIGHT);
MOVW	R0, #2
SXTH	R0, R0
BL	_modeChange+0
;movement.c,92 :: 		}
L_interruptTimer318:
;movement.c,93 :: 		}
IT	AL
BAL	L_interruptTimer319
L_interruptTimer315:
;movement.c,94 :: 		else if (MOVE_MODE_FORWARD == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer320
;movement.c,96 :: 		if (stepCnt > 0)
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer321
;movement.c,98 :: 		stepCnt --;
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;movement.c,99 :: 		}
IT	AL
BAL	L_interruptTimer322
L_interruptTimer321:
;movement.c,102 :: 		modeChange(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_modeChange+0
;movement.c,103 :: 		}
L_interruptTimer322:
;movement.c,104 :: 		}
IT	AL
BAL	L_interruptTimer323
L_interruptTimer320:
;movement.c,105 :: 		else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_interruptTimer324
;movement.c,107 :: 		if (stepCnt > 0)
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer325
;movement.c,109 :: 		stepCnt --;
MOVW	R1, #lo_addr(_stepCnt+0)
MOVT	R1, #hi_addr(_stepCnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;movement.c,110 :: 		}
IT	AL
BAL	L_interruptTimer326
L_interruptTimer325:
;movement.c,113 :: 		modeChange(MOVE_MODE_FORWARD);
MOVW	R0, #0
SXTH	R0, R0
BL	_modeChange+0
;movement.c,114 :: 		}
L_interruptTimer326:
;movement.c,115 :: 		}
L_interruptTimer324:
L_interruptTimer323:
L_interruptTimer319:
;movement.c,116 :: 		}
L_interruptTimer313:
;movement.c,118 :: 		if (isBluetoothReadyForTransmission()) //If data has been transmitted, send new data
BL	_isBluetoothReadyForTransmission+0
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer327
;movement.c,120 :: 		stringSendViaBluetooth("\n\rlightValueDetected: ");
MOVW	R0, #lo_addr(?lstr_1_movement+0)
MOVT	R0, #hi_addr(?lstr_1_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,121 :: 		intSendIntViaBluetooth(lightValueDetected);
MOVW	R0, #lo_addr(_lightValueDetected+0)
MOVT	R0, #hi_addr(_lightValueDetected+0)
LDRH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,123 :: 		stringSendViaBluetooth("CurLightValue: ");
MOVW	R0, #lo_addr(?lstr_2_movement+0)
MOVT	R0, #hi_addr(?lstr_2_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,124 :: 		intSendIntViaBluetooth(lightValueCurMax);
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
LDRH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,126 :: 		stringSendViaBluetooth("MaxLightValue: ");
MOVW	R0, #lo_addr(?lstr_3_movement+0)
MOVT	R0, #hi_addr(?lstr_3_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,127 :: 		intSendIntViaBluetooth(lightValueMax);
MOVW	R0, #lo_addr(_lightValueMax+0)
MOVT	R0, #hi_addr(_lightValueMax+0)
LDRH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,129 :: 		stringSendViaBluetooth("stepCnt: ");
MOVW	R0, #lo_addr(?lstr_4_movement+0)
MOVT	R0, #hi_addr(?lstr_4_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,130 :: 		intSendIntViaBluetooth(stepCnt);
MOVW	R0, #lo_addr(_stepCnt+0)
MOVT	R0, #hi_addr(_stepCnt+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,132 :: 		stringSendViaBluetooth("stepCntToDark: ");
MOVW	R0, #lo_addr(?lstr_5_movement+0)
MOVT	R0, #hi_addr(?lstr_5_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,133 :: 		intSendIntViaBluetooth(stepCntToDark);
MOVW	R0, #lo_addr(_stepCntToDark+0)
MOVT	R0, #hi_addr(_stepCntToDark+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;movement.c,135 :: 		stringSendViaBluetooth("Move:");
MOVW	R0, #lo_addr(?lstr_6_movement+0)
MOVT	R0, #hi_addr(?lstr_6_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,136 :: 		switch (moveMode)
IT	AL
BAL	L_interruptTimer328
;movement.c,138 :: 		case MOVE_MODE_FORWARD:
L_interruptTimer330:
;movement.c,139 :: 		stringSendViaBluetooth("FORWARD");
MOVW	R0, #lo_addr(?lstr_7_movement+0)
MOVT	R0, #hi_addr(?lstr_7_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,140 :: 		break;
IT	AL
BAL	L_interruptTimer329
;movement.c,141 :: 		case MOVE_MODE_CIRCLE:
L_interruptTimer331:
;movement.c,142 :: 		stringSendViaBluetooth("CIRCLE");
MOVW	R0, #lo_addr(?lstr_8_movement+0)
MOVT	R0, #hi_addr(?lstr_8_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,143 :: 		break;
IT	AL
BAL	L_interruptTimer329
;movement.c,144 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_interruptTimer332:
;movement.c,145 :: 		stringSendViaBluetooth("SEARCH_LIGHT");
MOVW	R0, #lo_addr(?lstr_9_movement+0)
MOVT	R0, #hi_addr(?lstr_9_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,146 :: 		break;
IT	AL
BAL	L_interruptTimer329
;movement.c,147 :: 		default:
L_interruptTimer333:
;movement.c,148 :: 		stringSendViaBluetooth("UNINITIALIZED");
MOVW	R0, #lo_addr(?lstr_10_movement+0)
MOVT	R0, #hi_addr(?lstr_10_movement+0)
BL	_stringSendViaBluetooth+0
;movement.c,149 :: 		}
IT	AL
BAL	L_interruptTimer329
L_interruptTimer328:
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer330
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_interruptTimer331
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_interruptTimer332
IT	AL
BAL	L_interruptTimer333
L_interruptTimer329:
;movement.c,150 :: 		intSendIntViaBluetooth(-1);
MOVW	R0, #65535
SXTH	R0, R0
BL	_intSendIntViaBluetooth+0
;movement.c,151 :: 		}
L_interruptTimer327:
;movement.c,153 :: 		}
L_end_interruptTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interruptTimer3
_detectionStart:
;movement.c,155 :: 		void detectionStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;movement.c,157 :: 		modeChange(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_modeChange+0
;movement.c,158 :: 		isPWMInitialized = true;
MOVS	R1, #1
MOVW	R0, #lo_addr(_isPWMInitialized+0)
MOVT	R0, #hi_addr(_isPWMInitialized+0)
STRB	R1, [R0, #0]
;movement.c,159 :: 		}
L_end_detectionStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _detectionStart
