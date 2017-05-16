_interruptTimer3:
;Light Moving Car.c,33 :: 		void interruptTimer3() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,34 :: 		TIM3_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,36 :: 		if (UART3_Tx_Idle() == 1) //If data has been transmitted, send new data
BL	_UART3_Tx_Idle+0
CMP	R0, #1
IT	NE
BNE	L_interruptTimer30
;Light Moving Car.c,44 :: 		IntToStr(-1, output);
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
MOVW	R0, #65535
SXTH	R0, R0
BL	_IntToStr+0
;Light Moving Car.c,45 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,46 :: 		for (i =  5000; i < 50000; i += 5000)
; i start address is: 32 (R8)
MOVW	R8, #5000
SXTH	R8, R8
; i end address is: 32 (R8)
L_interruptTimer31:
; i start address is: 32 (R8)
MOVW	R0, #50000
CMP	R8, R0
IT	CS
BCS	L_interruptTimer32
;Light Moving Car.c,48 :: 		pwmPeriod1 =  PWM_TIM1_Init(i);
SXTH	R0, R8
BL	_PWM_TIM1_Init+0
MOVW	R1, #lo_addr(_pwmPeriod1+0)
MOVT	R1, #hi_addr(_pwmPeriod1+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,49 :: 		IntToStr(pwmPeriod1, output);
SXTH	R0, R0
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,50 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,46 :: 		for (i =  5000; i < 50000; i += 5000)
MOVW	R0, #5000
SXTH	R0, R0
ADD	R8, R8, R0, LSL #0
SXTH	R8, R8
;Light Moving Car.c,52 :: 		}
; i end address is: 32 (R8)
IT	AL
BAL	L_interruptTimer31
L_interruptTimer32:
;Light Moving Car.c,53 :: 		}
L_interruptTimer30:
;Light Moving Car.c,55 :: 		}
L_end_interruptTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interruptTimer3
_initTimer3:
;Light Moving Car.c,58 :: 		void initTimer3(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,59 :: 		RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,60 :: 		TIM3_CR1.CEN = 0;// Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,61 :: 		TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];  // Set timer prescaler.
MOVW	R0, #lo_addr(_timer_psc+4)
MOVT	R0, #hi_addr(_timer_psc+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;Light Moving Car.c,62 :: 		TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE]; //
MOVW	R0, #lo_addr(_timer_arr+4)
MOVT	R0, #hi_addr(_timer_arr+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,63 :: 		NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
MOVW	R0, #45
BL	_NVIC_IntEnable+0
;Light Moving Car.c,64 :: 		TIM3_DIER.UIE = 1; // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;Light Moving Car.c,65 :: 		TIM3_CR1.CEN = 1; // Enable timer
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,66 :: 		}
L_end_initTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initTimer3
_initDebugMode:
;Light Moving Car.c,69 :: 		void initDebugMode ()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,72 :: 		UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART3_PD89+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART3_PD89+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART3_Init_Advanced+0
ADD	SP, SP, #4
;Light Moving Car.c,73 :: 		Delay_ms(1000);
MOVW	R7, #23038
MOVT	R7, #610
NOP
NOP
L_initDebugMode4:
SUBS	R7, R7, #1
BNE	L_initDebugMode4
NOP
NOP
NOP
;Light Moving Car.c,74 :: 		UART3_Enable();
BL	_UART3_Enable+0
;Light Moving Car.c,75 :: 		}
L_end_initDebugMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initDebugMode
_initADC:
;Light Moving Car.c,77 :: 		void initADC()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,79 :: 		GPIO_Analog_Input(&GPIOC_BASE, _GPIO_PINMASK_1);
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Analog_Input+0
;Light Moving Car.c,80 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_11);
MOVW	R0, #2048
BL	_ADC_Set_Input_Channel+0
;Light Moving Car.c,81 :: 		ADC1_Init();
BL	_ADC1_Init+0
;Light Moving Car.c,82 :: 		}
L_end_initADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initADC
_initPWM:
;Light Moving Car.c,84 :: 		void initPWM()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Light Moving Car.c,86 :: 		pwmPeriod1 = PWM_TIM1_Init(PERIOD_FREQUENCY);
MOVW	R0, #50
BL	_PWM_TIM1_Init+0
MOVW	R1, #lo_addr(_pwmPeriod1+0)
MOVT	R1, #hi_addr(_pwmPeriod1+0)
STR	R1, [SP, #4]
STRH	R0, [R1, #0]
;Light Moving Car.c,87 :: 		pwmPeriod2 = PWM_TIM2_Init(PERIOD_FREQUENCY);
MOVW	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwmPeriod2+0)
MOVT	R1, #hi_addr(_pwmPeriod2+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,88 :: 		currentDuty1 =  pwmPeriod1 / MAX_GEARS1;
LDR	R1, [SP, #4]
LDRH	R2, [R1, #0]
MOVW	R1, #23
UDIV	R2, R2, R1
MOVW	R1, #lo_addr(_currentDuty1+0)
MOVT	R1, #hi_addr(_currentDuty1+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,89 :: 		currentDuty2 = pwmPeriod2 / MAX_GEARS2;
MOVW	R1, #12
UDIV	R1, R0, R1
MOVW	R0, #lo_addr(_currentDuty2+0)
MOVT	R0, #hi_addr(_currentDuty2+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,90 :: 		PWM_TIM1_Set_Duty(currentDuty1,  _PWM_NON_INVERTED, _PWM_CHANNEL1);
UXTH	R0, R2
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM1_Set_Duty+0
;Light Moving Car.c,91 :: 		PWM_TIM2_Set_Duty(currentDuty2,  _PWM_NON_INVERTED, _PWM_CHANNEL3);
MOVW	R0, #lo_addr(_currentDuty2+0)
MOVT	R0, #hi_addr(_currentDuty2+0)
LDRH	R0, [R0, #0]
MOVS	R2, #2
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;Light Moving Car.c,93 :: 		PWM_TIM1_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM1_CH1_PE9);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM1_CH1_PE9+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM1_CH1_PE9+0)
MOVS	R0, #0
BL	_PWM_TIM1_Start+0
;Light Moving Car.c,94 :: 		PWM_TIM2_Start(_PWM_CHANNEL3, &_GPIO_MODULE_TIM2_CH3_PB10);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH3_PB10+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH3_PB10+0)
MOVS	R0, #2
BL	_PWM_TIM2_Start+0
;Light Moving Car.c,96 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_initPWM6:
SUBS	R7, R7, #1
BNE	L_initPWM6
NOP
NOP
NOP
;Light Moving Car.c,98 :: 		}
L_end_initPWM:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _initPWM
_main:
;Light Moving Car.c,101 :: 		void main() {
;Light Moving Car.c,103 :: 		initDebugMode();
BL	_initDebugMode+0
;Light Moving Car.c,104 :: 		initTimer3();
BL	_initTimer3+0
;Light Moving Car.c,105 :: 		initADC();
BL	_initADC+0
;Light Moving Car.c,106 :: 		initPWM();
BL	_initPWM+0
;Light Moving Car.c,108 :: 		while(1) {
L_main8:
;Light Moving Car.c,109 :: 		asm wfi;
WFI
;Light Moving Car.c,110 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_main10:
SUBS	R7, R7, #1
BNE	L_main10
NOP
NOP
NOP
;Light Moving Car.c,111 :: 		}
IT	AL
BAL	L_main8
;Light Moving Car.c,112 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
