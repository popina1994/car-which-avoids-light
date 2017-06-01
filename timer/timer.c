#include "timer.h"
#include "../logic/movement/movement.h"

void timer3Init(){
  RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 3
  TIM3_CR1.CEN = 0;// Disable timer
  TIM3_PSC = TIMER3_PRESCALER[TIMER3_INTERRUPT_MODE];  // Set timer prescaler.
  TIM3_ARR = TIMER3_ARR[TIMER3_INTERRUPT_MODE]; //
  NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
  TIM3_DIER.UIE = 1; // Update interrupt enable
  TIM3_CR1.CEN = 1; // Enable timer
}

void interruptTimer3() iv IVT_INT_TIM3 {
    TIM3_SR.UIF = 0;
    timerTicked();
}
