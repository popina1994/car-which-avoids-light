_startRightWheel:
;Light Moving Car.c,41 :: 		void startRightWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,43 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;Light Moving Car.c,44 :: 		}
L_end_startRightWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _startRightWheel
_stopRightWheel:
;Light Moving Car.c,46 :: 		void stopRightWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,48 :: 		PWM_TIM2_Stop(_PWM_CHANNEL2);
MOVS	R0, #1
BL	_PWM_TIM2_Stop+0
;Light Moving Car.c,49 :: 		}
L_end_stopRightWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _stopRightWheel
_startLeftWheel:
;Light Moving Car.c,51 :: 		void startLeftWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,53 :: 		PWM_TIM4_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM4_CH4_PB9);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
MOVS	R0, #3
BL	_PWM_TIM4_Start+0
;Light Moving Car.c,54 :: 		}
L_end_startLeftWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _startLeftWheel
_stopLeftWheel:
;Light Moving Car.c,56 :: 		void stopLeftWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,58 :: 		PWM_TIM4_Stop(_PWM_CHANNEL4);
MOVS	R0, #3
BL	_PWM_TIM4_Stop+0
;Light Moving Car.c,59 :: 		}
L_end_stopLeftWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _stopLeftWheel
_interruptTimer3:
;Light Moving Car.c,62 :: 		void interruptTimer3() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,63 :: 		TIM3_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,65 :: 		if (pwmInitialized)
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer30
;Light Moving Car.c,67 :: 		if (moveInCircle)
MOVW	R0, #lo_addr(_moveInCircle+0)
MOVT	R0, #hi_addr(_moveInCircle+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer31
;Light Moving Car.c,69 :: 		if (cntCircle > 0)
MOVW	R0, #lo_addr(_cntCircle+0)
MOVT	R0, #hi_addr(_cntCircle+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer32
;Light Moving Car.c,71 :: 		cntCircle --;
MOVW	R1, #lo_addr(_cntCircle+0)
MOVT	R1, #hi_addr(_cntCircle+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;Light Moving Car.c,72 :: 		}
IT	AL
BAL	L_interruptTimer33
L_interruptTimer32:
;Light Moving Car.c,75 :: 		moveInCircle = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_moveInCircle+0)
MOVT	R0, #hi_addr(_moveInCircle+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,76 :: 		startRightWheel();
BL	_startRightWheel+0
;Light Moving Car.c,77 :: 		startLeftWheel();
BL	_startLeftWheel+0
;Light Moving Car.c,78 :: 		cntMove = MAX_MOVE_BACK;
MOVW	R1, #100
SXTH	R1, R1
MOVW	R0, #lo_addr(_cntMove+0)
MOVT	R0, #hi_addr(_cntMove+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,79 :: 		}
L_interruptTimer33:
;Light Moving Car.c,80 :: 		}
IT	AL
BAL	L_interruptTimer34
L_interruptTimer31:
;Light Moving Car.c,83 :: 		if (cntMove > 0)
MOVW	R0, #lo_addr(_cntMove+0)
MOVT	R0, #hi_addr(_cntMove+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer35
;Light Moving Car.c,85 :: 		cntMove--;
MOVW	R1, #lo_addr(_cntMove+0)
MOVT	R1, #hi_addr(_cntMove+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;Light Moving Car.c,86 :: 		}
IT	AL
BAL	L_interruptTimer36
L_interruptTimer35:
;Light Moving Car.c,89 :: 		stopLeftWheel();
BL	_stopLeftWheel+0
;Light Moving Car.c,90 :: 		moveInCircle = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_moveInCircle+0)
MOVT	R0, #hi_addr(_moveInCircle+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,91 :: 		cntCircle =  MAX_MOVE_CIRCLE;
MOVW	R1, #100
SXTH	R1, R1
MOVW	R0, #lo_addr(_cntCircle+0)
MOVT	R0, #hi_addr(_cntCircle+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,92 :: 		}
L_interruptTimer36:
;Light Moving Car.c,93 :: 		}
L_interruptTimer34:
;Light Moving Car.c,94 :: 		}
L_interruptTimer30:
;Light Moving Car.c,96 :: 		if (UART3_Tx_Idle() == 1) //If data has been transmitted, send new data
BL	_UART3_Tx_Idle+0
CMP	R0, #1
IT	NE
BNE	L_interruptTimer37
;Light Moving Car.c,98 :: 		lightVal = ADC1_Get_Sample(11);
MOVS	R0, #11
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_lightVal+0)
MOVT	R1, #hi_addr(_lightVal+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,99 :: 		UART3_Write_Text("Light: ");
MOVW	R0, #lo_addr(?lstr1_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr1_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,100 :: 		IntToStr(lightVal, output);
MOVW	R0, #lo_addr(_lightVal+0)
MOVT	R0, #hi_addr(_lightVal+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,101 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,103 :: 		UART3_Write_Text("\n\rMove in circle: ");
MOVW	R0, #lo_addr(?lstr2_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr2_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,104 :: 		IntToStr(moveInCircle, output);
MOVW	R0, #lo_addr(_moveInCircle+0)
MOVT	R0, #hi_addr(_moveInCircle+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,105 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,107 :: 		UART3_Write_Text("CntMove: ");
MOVW	R0, #lo_addr(?lstr3_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr3_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,108 :: 		IntToStr(cntMove, output);
MOVW	R0, #lo_addr(_cntMove+0)
MOVT	R0, #hi_addr(_cntMove+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,109 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,111 :: 		UART3_Write_Text("CntCircle: ");
MOVW	R0, #lo_addr(?lstr4_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr4_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,112 :: 		IntToStr(cntCircle, output);
MOVW	R0, #lo_addr(_cntCircle+0)
MOVT	R0, #hi_addr(_cntCircle+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,113 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,115 :: 		IntToStr(-1, output);
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
MOVW	R0, #65535
SXTH	R0, R0
BL	_IntToStr+0
;Light Moving Car.c,116 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,117 :: 		}
L_interruptTimer37:
;Light Moving Car.c,120 :: 		}
L_end_interruptTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interruptTimer3
_initTimer3:
;Light Moving Car.c,123 :: 		void initTimer3(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,124 :: 		RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,125 :: 		TIM3_CR1.CEN = 0;// Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,126 :: 		TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];  // Set timer prescaler.
MOVW	R0, #lo_addr(_timer_psc+4)
MOVT	R0, #hi_addr(_timer_psc+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;Light Moving Car.c,127 :: 		TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE]; //
MOVW	R0, #lo_addr(_timer_arr+4)
MOVT	R0, #hi_addr(_timer_arr+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,128 :: 		NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
MOVW	R0, #45
BL	_NVIC_IntEnable+0
;Light Moving Car.c,129 :: 		TIM3_DIER.UIE = 1; // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;Light Moving Car.c,130 :: 		TIM3_CR1.CEN = 1; // Enable timer
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,131 :: 		}
L_end_initTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initTimer3
_initDebugMode:
;Light Moving Car.c,134 :: 		void initDebugMode ()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,137 :: 		UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART3_PD89+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART3_PD89+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART3_Init_Advanced+0
ADD	SP, SP, #4
;Light Moving Car.c,138 :: 		Delay_ms(1000);
MOVW	R7, #23038
MOVT	R7, #610
NOP
NOP
L_initDebugMode8:
SUBS	R7, R7, #1
BNE	L_initDebugMode8
NOP
NOP
NOP
;Light Moving Car.c,139 :: 		UART3_Enable();
BL	_UART3_Enable+0
;Light Moving Car.c,140 :: 		}
L_end_initDebugMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initDebugMode
_initADC:
;Light Moving Car.c,142 :: 		void initADC()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,145 :: 		GPIO_Analog_Input(&GPIOC_BASE, _GPIO_PINMASK_1);
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Analog_Input+0
;Light Moving Car.c,146 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_11);
MOVW	R0, #2048
BL	_ADC_Set_Input_Channel+0
;Light Moving Car.c,147 :: 		ADC1_Init();
BL	_ADC1_Init+0
;Light Moving Car.c,148 :: 		}
L_end_initADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initADC
_initPWM:
;Light Moving Car.c,150 :: 		void initPWM()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Light Moving Car.c,152 :: 		pwmPeriod1 = PWM_TIM4_Init(PERIOD_FREQUENCY1 );
MOVW	R0, #33
BL	_PWM_TIM4_Init+0
MOVW	R1, #lo_addr(_pwmPeriod1+0)
MOVT	R1, #hi_addr(_pwmPeriod1+0)
STR	R1, [SP, #4]
STRH	R0, [R1, #0]
;Light Moving Car.c,153 :: 		pwmPeriod2 = PWM_TIM2_Init(PERIOD_FREQUENCY2);
MOVW	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwmPeriod2+0)
MOVT	R1, #hi_addr(_pwmPeriod2+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,155 :: 		currentDuty1 =   pwmPeriod1 / MAX_GEARS2;
LDR	R1, [SP, #4]
LDRH	R2, [R1, #0]
MOVW	R1, #9
UDIV	R2, R2, R1
MOVW	R1, #lo_addr(_currentDuty1+0)
MOVT	R1, #hi_addr(_currentDuty1+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,156 :: 		currentDuty2 = pwmPeriod2 / MAX_GEARS2;
MOVW	R1, #9
UDIV	R1, R0, R1
MOVW	R0, #lo_addr(_currentDuty2+0)
MOVT	R0, #hi_addr(_currentDuty2+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,157 :: 		PWM_TIM4_Set_Duty(currentDuty1,  _PWM_NON_INVERTED, _PWM_CHANNEL4);
UXTH	R0, R2
MOVS	R2, #3
MOVS	R1, #0
BL	_PWM_TIM4_Set_Duty+0
;Light Moving Car.c,158 :: 		PWM_TIM2_Set_Duty(currentDuty2,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #lo_addr(_currentDuty2+0)
MOVT	R0, #hi_addr(_currentDuty2+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;Light Moving Car.c,162 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_initPWM10:
SUBS	R7, R7, #1
BNE	L_initPWM10
NOP
NOP
NOP
;Light Moving Car.c,163 :: 		moveInCircle = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_moveInCircle+0)
MOVT	R0, #hi_addr(_moveInCircle+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,164 :: 		pwmInitialized = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,166 :: 		}
L_end_initPWM:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _initPWM
_main:
;Light Moving Car.c,169 :: 		void main() {
;Light Moving Car.c,171 :: 		initDebugMode();
BL	_initDebugMode+0
;Light Moving Car.c,172 :: 		initTimer3();
BL	_initTimer3+0
;Light Moving Car.c,173 :: 		initADC();
BL	_initADC+0
;Light Moving Car.c,174 :: 		initPWM();
BL	_initPWM+0
;Light Moving Car.c,176 :: 		while(1) {
L_main12:
;Light Moving Car.c,177 :: 		asm wfi;
WFI
;Light Moving Car.c,178 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_main14:
SUBS	R7, R7, #1
BNE	L_main14
NOP
NOP
NOP
;Light Moving Car.c,179 :: 		}
IT	AL
BAL	L_main12
;Light Moving Car.c,180 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
