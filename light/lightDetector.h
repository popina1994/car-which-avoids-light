#ifndef  _LIGHT_DETECTOR_H_
#define _LIGHT_DETECTOR_H_

#include "../util/util.h"

#define ADC_CHANNEL_NUM 11
#define PIN_RCV_ADC_NAME C
#define PIN_RCV_ADC_IDX 1

#define ADC_CHANNEL_INTERNAL CONCAT_EXP(_ADC_CHANNEL_,\
 ADC_CHANNEL_NUM)

#define ADC_VERSION 1
#define ADC_INIT CONCAT_EXP(CONCAT_EXP(ADC, ADC_VERSION), _Init)
#define ADC_GET_SAMPLE CONCAT_EXP(CONCAT_EXP(ADC, ADC_VERSION), _Get_Sample)

void lightDetectorInit();

unsigned int getLightVal();

#endif // ! _LIGHT_H_
