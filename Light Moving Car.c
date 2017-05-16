
#define TIMER_SLOW_MODE 5
#define TIMER_INTERRUPT_MODE 2
#define TIMER_DEBOUNCE_MODE  1


unsigned scan_steps[] = {50, 200, 500, 1000};

//this is config for different times for timer interrupt
//                             5ms       20ms           50ms      100ms    200ms        500ms
unsigned timer_psc[] = {       9,        39,            95,       191,     374,         959   };
unsigned timer_arr[] = {       59999,    59999,         62499,    62499,   63999,       62499   };
int timer_times[]={            5,        20,            50,       100,     200,         500     };

// ************************************************** VARIABLES SECTION

// pin definitions
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


void Timer2_interrupt() iv IVT_INT_TIM2 {
  TIM2_SR.UIF = 0;

   if (UART3_Tx_Idle() == 1) //If data has been transmitted, send new data
     {
     /*
          pwmPeriod1
          lightVal = ADC1_Get_Sample(11);
          IntToStr(lightVal, output);
          UART3_Write_Text(output);*/
          int i;
                              IntToStr(-1, output);
          UART3_Write_Text(output);
          for (i =  5000; i < 50000; i += 5000)
          {
                    pwmPeriod1 =  PWM_TIM1_Init(i);
                    IntToStr(pwmPeriod1, output);
                    UART3_Write_Text(output);

                    }
     }

}


void init_timer2(){
  RCC_APB1ENR.TIM2EN = 1;  // Enable clock gating for timer module 2
  TIM2_CR1.CEN = 0;// Disable timer
  TIM2_PSC = timer_psc[TIMER_INTERRUPT_MODE];  // Set timer prescaler.
  TIM2_ARR = timer_arr[TIMER_INTERRUPT_MODE]; //
  NVIC_IntEnable(IVT_INT_TIM2);  // Enable timer interrupt
  TIM2_DIER.UIE = 1; // Update interrupt enable
  TIM2_CR1.CEN = 1; // Enable timer
}


void initDebugMode ()
{
     /* InitBluetoothUART3 */
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
{  // length of period
     pwmPeriod1 = PWM_TIM1_Init(PERIOD_FREQUENCY);
     pwmPeriod2 = PWM_TIM4_Init(PERIOD_FREQUENCY);
     currentDuty1 =  pwmPeriod1 / MAX_GEARS1;
     currentDuty2 = pwmPeriod2 / MAX_GEARS2;
     PWM_TIM1_Set_Duty(currentDuty1,  _PWM_NON_INVERTED, _PWM_CHANNEL1);
     PWM_TIM4_Set_Duty(currentDuty2,  _PWM_NON_INVERTED, _PWM_CHANNEL1);
          
     PWM_TIM1_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM1_CH1_PE9);
     PWM_TIM4_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM4_CH1_PD12);
     Delay_ms(100);

}

// ************************************************** MAIN SECTION
void main() {

     initDebugMode();
     init_timer2();
     initADC();
     initPWM();
     // Light led's
     // Signalize that all is initiated and radar can be used
     //LD1 = LD2 = 1;
//     Delay_ms(500);
     //LD1 = LD2 = 0;

     while(1) {
         asm wfi;
          Delay_ms(100);
     }
}