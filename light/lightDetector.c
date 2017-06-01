#include "lightDetector.h"

void lightDetectorInit()
{
    GPIO_Analog_Input(&PIN_NAME_EXP(PIN_RCV_ADC_NAME),
                        PIN_IDX_EXP(PIN_RCV_ADC_IDX));
    ADC_Set_Input_Channel(ADC_CHANNEL_INTERNAL);
    ADC_INIT();
}

unsigned int getLightVal()
{
    return ADC_GET_SAMPLE(ADC_CHANNEL_NUM);
}