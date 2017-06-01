#ifndef _LIGHT_DETECTION_H_
#define _LIGHT_DETECTION_H_

static const unsigned int MAX_ARR_LEN_LIGHT_VAL = 3;

extern unsigned int lightValueMax;
extern unsigned int lightValueCurMax;
extern unsigned int lightValueDetected;

void resetLightMaxPar();

void updateLightArray();

unsigned int lightValCalcAndUpdate();

#endif
