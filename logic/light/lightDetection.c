#include "lightDetection.h"
#include "../../light/lightDetector.h"

unsigned int lightValueMax = 0;
unsigned int lightValueCurMax;
unsigned int lightValueDetected = 0;
unsigned int lightValueArr[MAX_ARR_LEN_LIGHT_VAL] = {0};
void resetLightMaxPar()
{
    int idx;
    lightValueCurMax = 0;
    for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
    {
        lightValueArr[idx] = 0;
    }
    lightValueMax = 0;
}

void updateLightArray()
{
   int idx;
   for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
   {
       lightValueArr[idx] = lightValueArr[idx + 1];
   }
   lightValueDetected = getLightVal();
   lightValueArr[MAX_ARR_LEN_LIGHT_VAL - 1]= lightValueDetected;
}

unsigned int lightValCalcAndUpdate()
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
    lightValueCurMax = avg;
    return lightValueDetected;
}
