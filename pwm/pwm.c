#include "pwm.h"
#include "../wheel/left.h"
#include "../wheel/right.h"

void pwmInit()
{
    wheelLeftInit(MAX_GEARS);
    wheelRightInit(MAX_GEARS);
    Delay_ms(PWM_TIME_DELAY_MS);
}
