#line 1 "C:/Users/popina/Documents/MIPS/timer/timer.c"
#line 1 "c:/users/popina/documents/mips/timer/timer.h"




static const unsigned TIMER3_PRESCALER[] = { 9, 39, 95, 191, 374, 959 };
static const unsigned TIMER3_ARR[] = { 59999, 59999, 62499, 62499, 63999, 62499 };
static const unsigned int TIMER3_INTERRUPT_MODE = 2;

void timer3Init();
#line 3 "C:/Users/popina/Documents/MIPS/timer/timer.c"
void timer3Init(){
 RCC_APB1ENR.TIM3EN = 1;
 TIM3_CR1.CEN = 0;
 TIM3_PSC = TIMER3_PRESCALER[TIMER3_INTERRUPT_MODE];
 TIM3_ARR = TIMER3_ARR[TIMER3_INTERRUPT_MODE];
 NVIC_IntEnable(IVT_INT_TIM3);
 TIM3_DIER.UIE = 1;
 TIM3_CR1.CEN = 1;
}
