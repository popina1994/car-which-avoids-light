#include "movement.h"
#include "../light/lightDetection.h"
#include "../../wheel/left.h"
#include "../../wheel/right.h"
#include "../../pwm/pwm.h"
#include "../../bluetooth/bluetooth.h"
#include "../../light/lightDetector.h"
#include "../../timer/timer.h"

bool isPWMInitialized = false;
bool isStarted = false;
unsigned int moveMode;
int stepCnt = 0;
int stepCntToDark = -1;

void modeChange(int newMode)
{
    moveMode = newMode;
    isStarted = false;
    switch (newMode)
    {
        case MOVE_MODE_FORWARD:
           stepCnt = MAX_MOVE_BACK;
           break;
        case MOVE_MODE_CIRCLE:
            stepCnt = MAX_MOVE_CIRCLE;
            resetLightMaxPar();
            break;
        case MOVE_MODE_SEARCH_LIGHT:
            // reverse angle, it starts from zero and goes up to 2pi
            stepCntToDark = MAX_MOVE_CIRCLE - stepCntToDark;

            if ( (double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 0.5f)
            {
               stepCnt = MAX_MOVE_CIRCLE_HALF + stepCntToDark;
            }
            else if ((double)(stepCntToDark) / MAX_MOVE_CIRCLE <= 1f)
            {
                stepCnt = stepCntToDark - MAX_MOVE_CIRCLE_HALF;
            }
            break;
    }
}

void modeStart()
{
    isStarted = true;
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


void interruptTimer3() iv IVT_INT_TIM3 {

    TIM3_SR.UIF = 0;

    if (isPWMInitialized)
    {
        if (!isStarted )
        {
            modeStart();
        }
        if (MOVE_MODE_CIRCLE == moveMode)
        {
            if (stepCnt > 0)
            {
                stepCnt --;
                updateLightArray();
                lightValCalcAndUpdate();
                if (lightValueCurMax > lightValueMax)
                {
                    lightValueMax = lightValueCurMax;
                    stepCntToDark = stepCnt;
                }
            }
            else
            {
                modeChange(MOVE_MODE_SEARCH_LIGHT);
            }
        }
        else if (MOVE_MODE_FORWARD == moveMode)
        {
            if (stepCnt > 0)
            {
                stepCnt --;
            }
            else
            {
                modeChange(MOVE_MODE_CIRCLE);
            }
        }
        else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
        {
            if (stepCnt > 0)
            {
                stepCnt --;
            }
            else
            {
                modeChange(MOVE_MODE_FORWARD);
            }
        }
    }
#if DEBUG
    if (isBluetoothReadyForTransmission()) //If data has been transmitted, send new data
    {
        stringSendViaBluetooth("\n\rlightValueDetected: ");
        intSendIntViaBluetooth(lightValueDetected);

        stringSendViaBluetooth("CurLightValue: ");
        intSendIntViaBluetooth(lightValueCurMax);

        stringSendViaBluetooth("MaxLightValue: ");
        intSendIntViaBluetooth(lightValueMax);

        stringSendViaBluetooth("stepCnt: ");
        intSendIntViaBluetooth(stepCnt);

        stringSendViaBluetooth("stepCntToDark: ");
        intSendIntViaBluetooth(stepCntToDark);

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

void detectionStart()
{
    modeChange(MOVE_MODE_CIRCLE);
    isPWMInitialized = true;
}
