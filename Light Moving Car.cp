#line 1 "C:/Users/popina/Documents/MIPS/Light Moving Car.c"






unsigned scan_steps[] = {50, 200, 500, 1000};



unsigned timer_psc[] = { 9, 39, 95, 191, 374, 959 };
unsigned timer_arr[] = { 59999, 59999, 62499, 62499, 63999, 62499 };
int timer_times[]={ 5, 20, 50, 100, 200, 500 };




sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;
int lightVal = -1;
const int MAX_OUTPUT = 256;
char output[MAX_OUTPUT];

unsigned int currentDuty1;
unsigned int currentDuty2;
unsigned int pwmPeriod1;
unsigned int pwmPeriod2;
const int PERIOD_FREQUENCY = 50;
const int MAX_GEARS1 = 23;
const int MAX_GEARS2 = 12;


void Timer3_interrupt() iv IVT_INT_TIM3 {
 TIM3_SR.UIF = 0;

 if (UART3_Tx_Idle() == 1)
 {
#line 43 "C:/Users/popina/Documents/MIPS/Light Moving Car.c"
 int i;
 IntToStr(-1, output);
 UART3_Write_Text(output);
 for (i = 5000; i < 50000; i += 5000)
 {
 pwmPeriod1 = PWM_TIM1_Init(i);
 IntToStr(pwmPeriod1, output);
 UART3_Write_Text(output);

 }
 }

}


void initTimer3(){
 RCC_APB1ENR.TIM3EN = 1;
 TIM3_CR1.CEN = 0;
 TIM3_PSC = timer_psc[ 2 ];
 TIM3_ARR = timer_arr[ 2 ];
 NVIC_IntEnable(IVT_INT_TIM3);
 TIM3_DIER.UIE = 1;
 TIM3_CR1.CEN = 1;
}


void initDebugMode ()
{

 UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
 Delay_ms(1000);
 UART3_Enable();
}

void initADC()
{
 GPIO_Analog_Input(&GPIOC_BASE, _GPIO_PINMASK_1);
 ADC_Set_Input_Channel(_ADC_CHANNEL_11);
 ADC1_Init();
}

void initPWM()
{
 pwmPeriod1 = PWM_TIM1_Init(PERIOD_FREQUENCY);
 pwmPeriod2 = PWM_TIM2_Init(PERIOD_FREQUENCY);
 currentDuty1 = pwmPeriod1 / MAX_GEARS1;
 currentDuty2 = pwmPeriod2 / MAX_GEARS2;
 PWM_TIM1_Set_Duty(currentDuty1, _PWM_NON_INVERTED, _PWM_CHANNEL1);
 PWM_TIM2_Set_Duty(currentDuty2, _PWM_NON_INVERTED, _PWM_CHANNEL3);

 PWM_TIM1_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM1_CH1_PE9);
 PWM_TIM2_Start(_PWM_CHANNEL3, &_GPIO_MODULE_TIM2_CH3_PB10);

 Delay_ms(100);

}


void main() {

 initDebugMode();
 initTimer3();
 initADC();
 initPWM();

 while(1) {
 asm wfi;
 Delay_ms(100);
 }
}
