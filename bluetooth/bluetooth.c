#include "bluetooth.h"

char outputBuffer[OUTPUT_BUFFER_SIZE];

void bluetoothInit()
{
     UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
     UART3_Enable();
     Delay_ms(BLUETOOTH_TIME_DELAY_MS);
}

void stringSendViaBluetooth(char* str)
{
    UART3_Write_Text(str);
}

void intSendIntViaBluetooth(int val)
{
    IntToStr(val, outputBuffer);
    UART3_Write_Text(outputBuffer);
}
