_Timer2_interrupt:
;Light Moving Car.c,24 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,25 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,26 :: 		if (UART3_Tx_Idle() == 1) //If data has been transmitted, send new data
BL	_UART3_Tx_Idle+0
CMP	R0, #1
IT	NE
BNE	L_Timer2_interrupt0
;Light Moving Car.c,28 :: 		UART3_Write_Text("Timer!\r\n");
MOVW	R0, #lo_addr(?lstr1_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr1_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,29 :: 		}
L_Timer2_interrupt0:
;Light Moving Car.c,31 :: 		}
L_end_Timer2_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Timer2_interrupt
_init_timer2:
;Light Moving Car.c,34 :: 		void init_timer2(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,35 :: 		RCC_APB1ENR.TIM2EN = 1;  // Enable clock gating for timer module 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,36 :: 		TIM2_CR1.CEN = 0;// Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,37 :: 		TIM2_PSC = timer_psc[TIMER_SLOW_MODE];  // Set timer prescaler.
MOVW	R0, #lo_addr(_timer_psc+10)
MOVT	R0, #hi_addr(_timer_psc+10)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;Light Moving Car.c,38 :: 		TIM2_ARR = timer_arr[TIMER_SLOW_MODE]; //
MOVW	R0, #lo_addr(_timer_arr+10)
MOVT	R0, #hi_addr(_timer_arr+10)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,39 :: 		NVIC_IntEnable(IVT_INT_TIM2);  // Enable timer interrupt
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;Light Moving Car.c,40 :: 		TIM2_DIER.UIE = 1; // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;Light Moving Car.c,41 :: 		TIM2_CR1.CEN = 1; // Enable timer
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,42 :: 		}
L_end_init_timer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_pins:
;Light Moving Car.c,45 :: 		void init_pins () {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,47 :: 		UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART3_PD89+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART3_PD89+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART3_Init_Advanced+0
ADD	SP, SP, #4
;Light Moving Car.c,48 :: 		Delay_ms(1000);
MOVW	R7, #23038
MOVT	R7, #610
NOP
NOP
L_init_pins1:
SUBS	R7, R7, #1
BNE	L_init_pins1
NOP
NOP
NOP
;Light Moving Car.c,50 :: 		UART3_Enable();
BL	_UART3_Enable+0
;Light Moving Car.c,53 :: 		}
L_end_init_pins:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_pins
_main:
;Light Moving Car.c,57 :: 		void main() {
;Light Moving Car.c,59 :: 		init_pins();
BL	_init_pins+0
;Light Moving Car.c,60 :: 		init_timer2();
BL	_init_timer2+0
;Light Moving Car.c,65 :: 		Delay_ms(500);
MOVW	R7, #11518
MOVT	R7, #305
NOP
NOP
L_main3:
SUBS	R7, R7, #1
BNE	L_main3
NOP
NOP
NOP
;Light Moving Car.c,68 :: 		while(1) {
L_main5:
;Light Moving Car.c,69 :: 		asm wfi;
WFI
;Light Moving Car.c,70 :: 		}
IT	AL
BAL	L_main5
;Light Moving Car.c,71 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
