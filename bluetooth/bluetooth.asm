_bluetoothInit:
;bluetooth.c,5 :: 		void bluetoothInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;bluetooth.c,7 :: 		UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART3_PD89+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART3_PD89+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART3_Init_Advanced+0
ADD	SP, SP, #4
;bluetooth.c,8 :: 		UART3_Enable();
BL	_UART3_Enable+0
;bluetooth.c,9 :: 		Delay_ms(BLUETOOTH_TIME_DELAY_MS);
MOVW	R7, #23038
MOVT	R7, #610
NOP
NOP
L_bluetoothInit0:
SUBS	R7, R7, #1
BNE	L_bluetoothInit0
NOP
NOP
NOP
;bluetooth.c,10 :: 		}
L_end_bluetoothInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _bluetoothInit
_stringSendViaBluetooth:
;bluetooth.c,12 :: 		void stringSendViaBluetooth(char* str)
; str start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; str end address is: 0 (R0)
; str start address is: 0 (R0)
;bluetooth.c,14 :: 		UART3_Write_Text(str);
; str end address is: 0 (R0)
BL	_UART3_Write_Text+0
;bluetooth.c,15 :: 		}
L_end_stringSendViaBluetooth:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _stringSendViaBluetooth
_intSendIntViaBluetooth:
;bluetooth.c,17 :: 		void intSendIntViaBluetooth(int val)
; val start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; val end address is: 0 (R0)
; val start address is: 0 (R0)
;bluetooth.c,19 :: 		IntToStr(val, outputBuffer);
MOVW	R1, #lo_addr(_outputBuffer+0)
MOVT	R1, #hi_addr(_outputBuffer+0)
; val end address is: 0 (R0)
BL	_IntToStr+0
;bluetooth.c,20 :: 		UART3_Write_Text(outputBuffer);
MOVW	R0, #lo_addr(_outputBuffer+0)
MOVT	R0, #hi_addr(_outputBuffer+0)
BL	_UART3_Write_Text+0
;bluetooth.c,21 :: 		}
L_end_intSendIntViaBluetooth:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _intSendIntViaBluetooth
_isBluetoothReadyForTransmission:
;bluetooth.c,23 :: 		bool isBluetoothReadyForTransmission()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;bluetooth.c,25 :: 		if (UART3_Tx_Idle() == 1)
BL	_UART3_Tx_Idle+0
CMP	R0, #1
IT	NE
BNE	L_isBluetoothReadyForTransmission2
;bluetooth.c,27 :: 		return true;
MOVS	R0, #1
IT	AL
BAL	L_end_isBluetoothReadyForTransmission
;bluetooth.c,28 :: 		}
L_isBluetoothReadyForTransmission2:
;bluetooth.c,29 :: 		return false;
MOVS	R0, #0
;bluetooth.c,30 :: 		}
L_end_isBluetoothReadyForTransmission:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _isBluetoothReadyForTransmission
