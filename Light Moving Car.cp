#line 1 "C:/Users/popina/Documents/MIPS/Light Moving Car.c"







unsigned scan_steps[] = {50, 200, 500, 1000};



unsigned timer_psc[] = { 9, 39, 95, 191, 374, 959 };
unsigned timer_arr[] = { 59999, 59999, 62499, 62499, 63999, 62499 };
int timer_times[]={ 5, 20, 50, 100, 200, 500 };




sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;



int lightVal = -1;
const int MAX_OUTPUT = 256;
const int MAX_LIGHT_VAL = 5;
char output[MAX_OUTPUT];
int lightValueArr[MAX_LIGHT_VAL] = {0};

unsigned int currentDuty1;
unsigned int currentDuty2;
unsigned int pwmPeriod1;
unsigned int pwmPeriod2;
const int PERIOD_FREQUENCY1 = 33;
const int PERIOD_FREQUENCY2 = 50;
const int MAX_GEARS2 = 10;
const int MAX_MOVE_CIRCLE = 400;
const int MAX_MOVE_BACK = 400;

const int MOVE_MODE_BACK = 0;
const int MOVE_MODE_CIRCLE = 1;
const int MOVE_MODE_SEARCH_LIGHT = 2;

int maxLightValue = 0;
int moveMode = -1;
int isStarted = 0;
int cnt = 0;
int pwmInitialized = 0;
int curMaxLightValue;
const int EPSILON = 5;

void startRightWheel()
{
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
}

void stopRightWheel()
{
 PWM_TIM2_Stop(_PWM_CHANNEL2);
}

void startLeftWheel()
{
 PWM_TIM4_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM4_CH4_PB9);
}

void stopLeftWheel()
{
 PWM_TIM4_Stop(_PWM_CHANNEL4);
}

void resetLightMaxPar()
{ int idx;
 curMaxLightValue = 0;
 for (idx = 0; idx < MAX_LIGHT_VAL; idx ++ )
 {
 lightValueArr[idx] = 0;
 }
}

void changeMode(int newMode)
{
 moveMode = newMode;
 isStarted = 0;
 switch (newMode)
 {
 case MOVE_MODE_BACK:
 cnt = MAX_MOVE_BACK;
 break;
 case MOVE_MODE_CIRCLE:
 cnt = MAX_MOVE_CIRCLE;
 resetLightMaxPar();
 maxLightValue = 0;
 break;
 case MOVE_MODE_SEARCH_LIGHT:
 resetLightMaxPar();
 break;


 }
}

void startMode()
{
 int idx;
 isStarted = 0;
 switch (moveMode)
 {
 case MOVE_MODE_BACK:
 startRightWheel();
 startLeftWheel();
 break;
 case MOVE_MODE_CIRCLE:
 stopLeftWheel();
 startRightWheel();
 break;
 case MOVE_MODE_SEARCH_LIGHT:
 startRightWheel();
 stopLeftWheel();
 break;
 }
}

int calcLightVal()
{
 int idx;
 int min = 30000;
 int max = -1;
 int minIdx = -1;
 int maxIdx = -1;
 int cnt = 0;
 int avg = 0;
 for (idx = 0; idx < MAX_LIGHT_VAL; idx ++)
 {
 if (lightValueArr[idx] > max)
 {
 max = lightValueArr[idx];
 maxIdx = idx;
 }

 if (lightValueArr[idx] < min)
 {
 min = lightValueArr[idx];
 minIdx = idx;
 }
 }


 for (idx = 0; idx < MAX_LIGHT_VAL; idx ++)
 {
 if ( (idx != minIdx) && (idx != maxIdx))
 {
 cnt ++;
 avg += lightValueArr[idx];
 }
 }
 avg /= cnt;
 return avg;
}

void updateLightArray()
{
 int idx;
 for (idx = 0; idx < MAX_LIGHT_VAL - 1; idx ++)
 {
 lightValueArr[idx] = lightValueArr[idx + 1];
 }
 lightVal = ADC1_Get_Sample(11);
 lightValueArr[MAX_LIGHT_VAL - 1]= lightVal;
}

void interruptTimer3() iv IVT_INT_TIM3 {

 TIM3_SR.UIF = 0;

 if (pwmInitialized)
 {
 if (!isStarted)
 {
 startMode();
 }
 if (MOVE_MODE_CIRCLE == moveMode)
 {
 if (cnt > 0)
 {
 cnt --;
 updateLightArray();
 curMaxLightValue = calcLightVal();
 if (curMaxLightValue > maxLightValue)
 {
 maxLightValue = curMaxLightValue;
 }
 }
 else
 {
 changeMode(MOVE_MODE_SEARCH_LIGHT);
 }
 }
 else if (MOVE_MODE_BACK == moveMode)
 {
 if (cnt > 0)
 {
 cnt --;

 }
 else
 {
 changeMode(MOVE_MODE_CIRCLE);
 }
 }
 else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
 {
 updateLightArray();
 curMaxLightValue = calcLightVal();
 if ( abs(curMaxLightValue - maxLightValue) < EPSILON)
 {
 changeMode(MOVE_MODE_BACK);

 }
 }
 }

 if (UART3_Tx_Idle() == 1)
 {
 lightVal = ADC1_Get_Sample(11);
 UART3_Write_Text("\n\rLight: ");
 IntToStr(lightVal, output);
 UART3_Write_Text(output);

 UART3_Write_Text("CurLightValue: ");
 IntToStr(curMaxLightValue, output);
 UART3_Write_Text(output);

 UART3_Write_Text("MaxLightValue: ");
 IntToStr(maxLightValue, output);
 UART3_Write_Text(output);

 UART3_Write_Text("Cnt: ");
 IntToStr(cnt, output);
 UART3_Write_Text(output);

 UART3_Write_Text("Move:");
 if (moveMode == MOVE_MODE_BACK)
 {
 UART3_Write_Text("BACK");
 }
 else if (moveMode == MOVE_MODE_CIRCLE)
 {
 UART3_Write_Text("CIRCLE");
 }
 else if (moveMode == MOVE_MODE_SEARCH_LIGHT)
 {
 UART3_Write_Text("SEARCH LIGHT");
 }

 IntToStr(-1, output);
 UART3_Write_Text(output);
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
 pwmPeriod1 = PWM_TIM4_Init(PERIOD_FREQUENCY1 );
 pwmPeriod2 = PWM_TIM2_Init(PERIOD_FREQUENCY2);

 currentDuty1 = pwmPeriod1 / MAX_GEARS2;
 currentDuty2 = pwmPeriod2 / MAX_GEARS2;
 PWM_TIM4_Set_Duty(currentDuty1, _PWM_NON_INVERTED, _PWM_CHANNEL4);
 PWM_TIM2_Set_Duty(currentDuty2, _PWM_NON_INVERTED, _PWM_CHANNEL2);



 changeMode(MOVE_MODE_CIRCLE);
 Delay_ms(100);
 pwmInitialized = 1;

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
