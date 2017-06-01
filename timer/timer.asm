_timer3Init:
;timer.c,3 :: 		void timer3Init(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;timer.c,4 :: 		RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 3
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;timer.c,5 :: 		TIM3_CR1.CEN = 0;// Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;timer.c,6 :: 		TIM3_PSC = TIMER3_PRESCALER[TIMER3_INTERRUPT_MODE];  // Set timer prescaler.
MOVW	R1, #95
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;timer.c,7 :: 		TIM3_ARR = TIMER3_ARR[TIMER3_INTERRUPT_MODE]; //
MOVW	R1, #62499
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;timer.c,8 :: 		NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
MOVW	R0, #45
BL	_NVIC_IntEnable+0
;timer.c,9 :: 		TIM3_DIER.UIE = 1; // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;timer.c,10 :: 		TIM3_CR1.CEN = 1; // Enable timer
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;timer.c,11 :: 		}
L_end_timer3Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _timer3Init
