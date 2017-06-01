#line 1 "C:/Users/popina/Documents/MIPS/logic/light/lightDetection.c"
#line 1 "c:/users/popina/documents/mips/logic/light/lightdetection.h"



static const unsigned int MAX_ARR_LEN_LIGHT_VAL = 3;

extern unsigned int lightValueMax;
extern unsigned int lightValueCurMax;
extern unsigned int lightValueDetected;

void resetLightMaxPar();

void updateLightArray();

unsigned int lightValCalcAndUpdate();
#line 1 "c:/users/popina/documents/mips/logic/light/../../light/lightdetector.h"
#line 1 "c:/users/popina/documents/mips/logic/light/../../light/../util/util.h"
#line 17 "c:/users/popina/documents/mips/logic/light/../../light/lightdetector.h"
void lightDetectorInit();

unsigned int getLightVal();
#line 4 "C:/Users/popina/Documents/MIPS/logic/light/lightDetection.c"
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
