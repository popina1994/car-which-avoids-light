#include "pwm/pwm.h"
#include "bluetooth/bluetooth.h"
#include "light/lightDetector.h"
#include "timer/timer.h"
#include "logic/light/lightDetection.h"
#include "logic/movement/movement.h"

void main() {

    bluetoothInit();
    lightDetectorInit();
    pwmInit();
    timer3Init();
    detectionStart();

    while (true)
    {
        INST_STANDBY;
        Delay_ms(CPU_DELAY_TIME_MS);
     }
}
