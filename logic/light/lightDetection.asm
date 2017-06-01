_resetLightMaxPar:
;lightDetection.c,8 :: 		void resetLightMaxPar()
;lightDetection.c,11 :: 		lightValueCurMax = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
STRH	R1, [R0, #0]
;lightDetection.c,12 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
; idx start address is: 8 (R2)
MOVS	R2, #0
SXTH	R2, R2
; idx end address is: 8 (R2)
L_resetLightMaxPar0:
; idx start address is: 8 (R2)
CMP	R2, #3
IT	CS
BCS	L_resetLightMaxPar1
;lightDetection.c,14 :: 		lightValueArr[idx] = 0;
LSLS	R1, R2, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRH	R0, [R1, #0]
;lightDetection.c,12 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
ADDS	R2, R2, #1
SXTH	R2, R2
;lightDetection.c,15 :: 		}
; idx end address is: 8 (R2)
IT	AL
BAL	L_resetLightMaxPar0
L_resetLightMaxPar1:
;lightDetection.c,16 :: 		lightValueMax = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_lightValueMax+0)
MOVT	R0, #hi_addr(_lightValueMax+0)
STRH	R1, [R0, #0]
;lightDetection.c,17 :: 		}
L_end_resetLightMaxPar:
BX	LR
; end of _resetLightMaxPar
_updateLightArray:
;lightDetection.c,19 :: 		void updateLightArray()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;lightDetection.c,22 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
; idx start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; idx end address is: 12 (R3)
L_updateLightArray3:
; idx start address is: 12 (R3)
CMP	R3, #2
IT	GE
BGE	L_updateLightArray4
;lightDetection.c,24 :: 		lightValueArr[idx] = lightValueArr[idx + 1];
LSLS	R1, R3, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R2, R0, R1
ADDS	R0, R3, #1
SXTH	R0, R0
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
STRH	R0, [R2, #0]
;lightDetection.c,22 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
ADDS	R3, R3, #1
SXTH	R3, R3
;lightDetection.c,25 :: 		}
; idx end address is: 12 (R3)
IT	AL
BAL	L_updateLightArray3
L_updateLightArray4:
;lightDetection.c,26 :: 		lightValueDetected = getLightVal();
BL	_getLightVal+0
MOVW	R1, #lo_addr(_lightValueDetected+0)
MOVT	R1, #hi_addr(_lightValueDetected+0)
STRH	R0, [R1, #0]
;lightDetection.c,27 :: 		lightValueArr[MAX_ARR_LEN_LIGHT_VAL - 1]= lightValueDetected;
MOVW	R1, #lo_addr(_lightValueArr+4)
MOVT	R1, #hi_addr(_lightValueArr+4)
STRH	R0, [R1, #0]
;lightDetection.c,28 :: 		}
L_end_updateLightArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _updateLightArray
_lightValCalcAndUpdate:
;lightDetection.c,30 :: 		unsigned int lightValCalcAndUpdate()
SUB	SP, SP, #4
;lightDetection.c,33 :: 		int min = 30000;
; min start address is: 28 (R7)
MOVW	R7, #30000
SXTH	R7, R7
;lightDetection.c,34 :: 		int max = -1;
; max start address is: 32 (R8)
MOVW	R8, #65535
SXTH	R8, R8
;lightDetection.c,35 :: 		int minIdx = -1;
; minIdx start address is: 24 (R6)
MOVW	R6, #65535
SXTH	R6, R6
;lightDetection.c,36 :: 		int maxIdx = -1;
; maxIdx start address is: 20 (R5)
MOVW	R5, #65535
SXTH	R5, R5
;lightDetection.c,37 :: 		int cnt = 0;
; cnt start address is: 12 (R3)
MOVW	R3, #0
SXTH	R3, R3
;lightDetection.c,38 :: 		int avg = 0;
; avg start address is: 8 (R2)
MOVW	R2, #0
SXTH	R2, R2
;lightDetection.c,39 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; idx start address is: 16 (R4)
MOVS	R4, #0
SXTH	R4, R4
; avg end address is: 8 (R2)
; cnt end address is: 12 (R3)
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
; idx end address is: 16 (R4)
L_lightValCalcAndUpdate6:
; idx start address is: 16 (R4)
; avg start address is: 8 (R2)
; cnt start address is: 12 (R3)
; maxIdx start address is: 20 (R5)
; minIdx start address is: 24 (R6)
; max start address is: 32 (R8)
; min start address is: 28 (R7)
CMP	R4, #3
IT	CS
BCS	L_lightValCalcAndUpdate7
;lightDetection.c,41 :: 		if (lightValueArr[idx] > max)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
CMP	R0, R8
IT	LS
BLS	L__lightValCalcAndUpdate20
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;lightDetection.c,43 :: 		max = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRH	R8, [R0, #0]
; max start address is: 32 (R8)
;lightDetection.c,44 :: 		maxIdx = idx;
; maxIdx start address is: 20 (R5)
SXTH	R5, R4
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;lightDetection.c,45 :: 		}
IT	AL
BAL	L_lightValCalcAndUpdate9
L__lightValCalcAndUpdate20:
;lightDetection.c,41 :: 		if (lightValueArr[idx] > max)
;lightDetection.c,45 :: 		}
L_lightValCalcAndUpdate9:
;lightDetection.c,47 :: 		if (lightValueArr[idx] < min)
; maxIdx start address is: 20 (R5)
; max start address is: 32 (R8)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
CMP	R0, R7
IT	CS
BCS	L__lightValCalcAndUpdate21
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;lightDetection.c,49 :: 		min = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRH	R7, [R0, #0]
; min start address is: 28 (R7)
;lightDetection.c,50 :: 		minIdx = idx;
; minIdx start address is: 24 (R6)
SXTH	R6, R4
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;lightDetection.c,51 :: 		}
IT	AL
BAL	L_lightValCalcAndUpdate10
L__lightValCalcAndUpdate21:
;lightDetection.c,47 :: 		if (lightValueArr[idx] < min)
;lightDetection.c,51 :: 		}
L_lightValCalcAndUpdate10:
;lightDetection.c,39 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; minIdx start address is: 24 (R6)
; min start address is: 28 (R7)
ADDS	R4, R4, #1
SXTH	R4, R4
;lightDetection.c,52 :: 		}
; max end address is: 32 (R8)
; min end address is: 28 (R7)
; idx end address is: 16 (R4)
IT	AL
BAL	L_lightValCalcAndUpdate6
L_lightValCalcAndUpdate7:
;lightDetection.c,54 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; idx start address is: 16 (R4)
MOVS	R4, #0
SXTH	R4, R4
; avg end address is: 8 (R2)
; cnt end address is: 12 (R3)
; maxIdx end address is: 20 (R5)
; minIdx end address is: 24 (R6)
; idx end address is: 16 (R4)
STRH	R6, [SP, #0]
SXTH	R6, R3
SXTH	R3, R5
SXTH	R5, R2
LDRSH	R2, [SP, #0]
L_lightValCalcAndUpdate11:
; idx start address is: 16 (R4)
; maxIdx start address is: 12 (R3)
; minIdx start address is: 8 (R2)
; minIdx start address is: 8 (R2)
; minIdx end address is: 8 (R2)
; maxIdx start address is: 12 (R3)
; maxIdx end address is: 12 (R3)
; cnt start address is: 24 (R6)
; avg start address is: 20 (R5)
CMP	R4, #3
IT	CS
BCS	L_lightValCalcAndUpdate12
; minIdx end address is: 8 (R2)
; maxIdx end address is: 12 (R3)
;lightDetection.c,56 :: 		if ( (idx != minIdx) && (idx != maxIdx))
; maxIdx start address is: 12 (R3)
; minIdx start address is: 8 (R2)
CMP	R4, R2
IT	EQ
BEQ	L__lightValCalcAndUpdate22
CMP	R4, R3
IT	EQ
BEQ	L__lightValCalcAndUpdate23
L__lightValCalcAndUpdate17:
;lightDetection.c,58 :: 		cnt ++;
ADDS	R6, R6, #1
SXTH	R6, R6
;lightDetection.c,59 :: 		avg += lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
ADDS	R0, R5, R0
; avg end address is: 20 (R5)
; avg start address is: 4 (R1)
SXTH	R1, R0
; avg end address is: 4 (R1)
; cnt end address is: 24 (R6)
SXTH	R5, R1
;lightDetection.c,56 :: 		if ( (idx != minIdx) && (idx != maxIdx))
IT	AL
BAL	L__lightValCalcAndUpdate19
L__lightValCalcAndUpdate22:
L__lightValCalcAndUpdate19:
; avg start address is: 20 (R5)
; cnt start address is: 24 (R6)
; cnt end address is: 24 (R6)
; avg end address is: 20 (R5)
IT	AL
BAL	L__lightValCalcAndUpdate18
L__lightValCalcAndUpdate23:
L__lightValCalcAndUpdate18:
;lightDetection.c,54 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; cnt start address is: 24 (R6)
; avg start address is: 20 (R5)
ADDS	R4, R4, #1
SXTH	R4, R4
;lightDetection.c,61 :: 		}
; minIdx end address is: 8 (R2)
; maxIdx end address is: 12 (R3)
; idx end address is: 16 (R4)
IT	AL
BAL	L_lightValCalcAndUpdate11
L_lightValCalcAndUpdate12:
;lightDetection.c,62 :: 		avg /= cnt;
SDIV	R1, R5, R6
; cnt end address is: 24 (R6)
; avg end address is: 20 (R5)
;lightDetection.c,63 :: 		lightValueCurMax = avg;
MOVW	R0, #lo_addr(_lightValueCurMax+0)
MOVT	R0, #hi_addr(_lightValueCurMax+0)
STRH	R1, [R0, #0]
;lightDetection.c,64 :: 		return lightValueDetected;
MOVW	R0, #lo_addr(_lightValueDetected+0)
MOVT	R0, #hi_addr(_lightValueDetected+0)
LDRH	R0, [R0, #0]
;lightDetection.c,65 :: 		}
L_end_lightValCalcAndUpdate:
ADD	SP, SP, #4
BX	LR
; end of _lightValCalcAndUpdate
