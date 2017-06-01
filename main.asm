_main:
;main.c,8 :: 		void main() {
;main.c,10 :: 		bluetoothInit();
BL	_bluetoothInit+0
;main.c,11 :: 		lightDetectorInit();
BL	_lightDetectorInit+0
;main.c,12 :: 		pwmInit();
BL	_pwmInit+0
;main.c,13 :: 		timer3Init();
BL	_timer3Init+0
;main.c,14 :: 		detectionStart();
BL	_detectionStart+0
;main.c,16 :: 		while (true)
L_main0:
;main.c,18 :: 		INST_STANDBY;
WFI
;main.c,19 :: 		Delay_ms(CPU_DELAY_TIME_MS);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
;main.c,20 :: 		}
IT	AL
BAL	L_main0
;main.c,21 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
