#line 1 "C:/Users/popina/Documents/MIPS/light/lightDetector.c"
#line 1 "c:/users/popina/documents/mips/light/lightdetector.h"
#line 1 "c:/users/popina/documents/mips/light/../util/util.h"
#line 15 "c:/users/popina/documents/mips/light/lightdetector.h"
void lightDetectorInit();

unsigned int getLightVal();
#line 3 "C:/Users/popina/Documents/MIPS/light/lightDetector.c"
void lightDetectorInit()
{
 GPIO_Analog_Input(& GPIOC_BASE ,
  _GPIO_PINMASK_1 );
 ADC_Set_Input_Channel( _ADC_CHANNEL_11 );
  ADC1_Init ();
}

unsigned int getLightVal()
{
 return  ADC1_Get_Sample ( 11 );
}
