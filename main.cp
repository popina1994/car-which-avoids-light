#line 1 "C:/Users/popina/Documents/MIPS/main.c"
#line 1 "c:/users/popina/documents/mips/wheel/left.h"



extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftStart();



void wheelLeftInit();

void wheelLeftStop();
#line 1 "c:/users/popina/documents/mips/wheel/right.h"



extern int wheelRightCurrentDuty;
static const int WHEEL_RIGHT_FREQUENCY_PERIOD = 50;

void wheelRightInit();



void wheelRightStart();

void wheelRightStop();
#line 1 "c:/users/popina/documents/mips/bluetooth/bluetooth.h"
#line 1 "c:/users/popina/documents/mips/light/lightdetector.h"
#line 8 "C:/Users/popina/Documents/MIPS/main.c"
unsigned timer_psc[] = { 9, 39, 95, 191, 374, 959 };
unsigned timer_arr[] = { 59999, 59999, 62499, 62499, 63999, 62499 };

const int TIMER_INTERRUPT_MODE = 2;

int lightValDetected = -1;
const int MAX_OUTPUT_LEN = 256;
const int MAX_ARR_LEN_LIGHT_VAL = 3;
char output[MAX_OUTPUT_LEN];
int lightValueArr[MAX_ARR_LEN_LIGHT_VAL] = {0};

const int MAX_MOVE_CIRCLE = 440;
const int MAX_MOVE_CIRCLE_HALF = MAX_MOVE_CIRCLE / 2;
const int MAX_MOVE_BACK = 50;

const int MOVE_MODE_FORWARD = 0;
const int MOVE_MODE_CIRCLE = 1;
const int MOVE_MODE_SEARCH_LIGHT = 2;

int maxLightValue = 0;
int moveMode = -1;
int isStarted = 0;
int cnt = 0;
int cntFound = -1;
int pwmInitialized = 0;
int curMaxLightValue;

void resetLightMaxPar()
{ int idx;
 curMaxLightValue = 0;
 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
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
 case MOVE_MODE_FORWARD:
 cnt = MAX_MOVE_BACK;
 break;
 case MOVE_MODE_CIRCLE:
 cnt = MAX_MOVE_CIRCLE;
 resetLightMaxPar();
 maxLightValue = 0;
 break;
 case MOVE_MODE_SEARCH_LIGHT:

 cntFound = MAX_MOVE_CIRCLE - cntFound;

 if ( (double)(cntFound) / MAX_MOVE_CIRCLE <= 0.5f)
 {
 cnt = MAX_MOVE_CIRCLE_HALF + cntFound;
 }
 else if ((double)(cntFound) / MAX_MOVE_CIRCLE <= 1f)
 {
 cnt = cntFound - MAX_MOVE_CIRCLE_HALF;
 }
 break;
 }
}

void startMode()
{
 isStarted = 0;
 switch (moveMode)
 {
 case MOVE_MODE_FORWARD:
 wheelRightStart();
 wheelLeftStart();
 break;
 case MOVE_MODE_CIRCLE:
 wheelLeftStop();
 wheelRightStart();
 break;
 case MOVE_MODE_SEARCH_LIGHT:

 wheelRightStart();
 wheelLeftStop();
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
 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
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


 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
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
 for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
 {
 lightValueArr[idx] = lightValueArr[idx + 1];
 }
 lightValDetected = ADC1_Get_Sample(11);
 lightValueArr[MAX_ARR_LEN_LIGHT_VAL - 1]= lightValDetected;
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
 cntFound = cnt;
 }
 }
 else
 {
 changeMode(MOVE_MODE_SEARCH_LIGHT);
 }
 }
 else if (MOVE_MODE_FORWARD == moveMode)
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
 if (cnt > 0)
 {
 cnt --;
 }
 else
 {
 changeMode(MOVE_MODE_FORWARD);
 }
 }
 }

 if (UART3_Tx_Idle() == 1)
 {
 UART3_Write_Text("\n\rLightValDetected: ");
 IntToStr(lightValDetected, output);
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

 UART3_Write_Text("CntFound: ");
 IntToStr(cntFound, output);
 UART3_Write_Text(output);

 UART3_Write_Text("Move:");
 if (moveMode == MOVE_MODE_FORWARD)
 {
 UART3_Write_Text("FORWARD");
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
 TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];
 TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE];
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
 wheelLeftInit();
 wheelRightInit();

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
