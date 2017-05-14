#line 1 "C:/Users/popina/Documents/MIPS/Light Moving Car.c"







unsigned scan_steps[] = {50, 200, 500, 1000};



unsigned timer_psc[] = { 9, 39, 95, 191, 374, 959 };
unsigned timer_arr[] = { 59999, 59999, 62499, 62499, 63999, 62499 };
int timer_times[]={ 5, 20, 50, 100, 200, 500 };




sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;



void Timer2_interrupt() iv IVT_INT_TIM2 {
 TIM2_SR.UIF = 0;
 if (UART3_Tx_Idle() == 1)
 {
 UART3_Write_Text("Timer!\r\n");
 }

}


void init_timer2(){
 RCC_APB1ENR.TIM2EN = 1;
 TIM2_CR1.CEN = 0;
 TIM2_PSC = timer_psc[ 5 ];
 TIM2_ARR = timer_arr[ 5 ];
 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIER.UIE = 1;
 TIM2_CR1.CEN = 1;
}


void init_pins () {

 UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
 Delay_ms(1000);

 UART3_Enable();

 USART3_CR1bits.RXNEIE = 1;
 USART3_CR1bits.TXEIE = 0;

}



void main() {

 init_pins();
 init_timer2();




 Delay_ms(500);


 while(1) {
 asm wfi;
 }
}
