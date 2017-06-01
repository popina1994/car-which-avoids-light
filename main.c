#include "wheel/left.h"
#include "wheel/right.h"
#include "pwm/pwm.h"
#include "bluetooth/bluetooth.h"
#include "light/lightDetector.h"

#define DEBUG 1
//                             5ms       20ms           50ms      100ms    200ms        500ms
unsigned timer_psc[] = {       9,        39,            95,       191,     374,         959   };
unsigned timer_arr[] = {       59999,    59999,         62499,    62499,   63999,       62499   };

const int TIMER_INTERRUPT_MODE  = 2;

int lightValDetected = -1;
const int MAX_ARR_LEN_LIGHT_VAL = 3;
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
{   int idx;
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
       // reverse angle, it starts from zero and goes up to 2pi
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
   lightValDetected = getLightVal();
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
#if DEBUG
    if (isBluetoothReadyForTransmission() ) //If data has been transmitted, send new data
    {
      stringSendViaBluetooth("\n\rLightValDetected: ");
      intSendIntViaBluetooth(lightValDetected);

      stringSendViaBluetooth("CurLightValue: ");
      intSendIntViaBluetooth(curMaxLightValue);

      stringSendViaBluetooth("MaxLightValue: ");
      intSendIntViaBluetooth(maxLightValue);

      stringSendViaBluetooth("Cnt: ");
      intSendIntViaBluetooth(cnt);

      stringSendViaBluetooth("CntFound: ");
      intSendIntViaBluetooth(cntFound);

      stringSendViaBluetooth("Move:");
      switch (moveMode)
      {
        case MOVE_MODE_FORWARD:
          stringSendViaBluetooth("FORWARD");
          break;
        case MOVE_MODE_CIRCLE:
          stringSendViaBluetooth("CIRCLE");
          break;
        case MOVE_MODE_SEARCH_LIGHT:
          stringSendViaBluetooth("SEARCH_LIGHT");
          break;
        default:
          stringSendViaBluetooth("UNINITIALIZED");
      }
      intSendIntViaBluetooth(-1);
    }
#endif
}

void initTimer3(){
  RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 3
  TIM3_CR1.CEN = 0;// Disable timer
  TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];  // Set timer prescaler.
  TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE]; //
  NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
  TIM3_DIER.UIE = 1; // Update interrupt enable
  TIM3_CR1.CEN = 1; // Enable timer
}

void initPWMLog()
{
    pwmInit();
    changeMode(MOVE_MODE_CIRCLE);

    pwmInitialized = 1;
}

void main() {

    bluetoothInit();
     initTimer3();
    lightDetectorInit();
     initPWMLog();

     while(1) {
         asm wfi;
          Delay_ms(100);
     }
}
