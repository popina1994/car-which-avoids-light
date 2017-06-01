#include "bluetooth.h"

char outputBuffer[OUTPUT_BUFFER_SIZE];

void bluetoothInit()
{
     UART_INIT_ADVANCED(BAUD_RATE, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &UART_MODULE_PIN_TR_RC);
     UART_ENABLE();
     Delay_ms(BLUETOOTH_TIME_DELAY_MS);
}

void stringSendViaBluetooth(char* str)
{
    UART_WRITE_TEXT(str);
}

void intSendIntViaBluetooth(int val)
{
    IntToStr(val, outputBuffer);
    UART_WRITE_TEXT(outputBuffer);
}

bool isBluetoothReadyForTransmission()
{
    if (UART_TX_IDLE() == 1)
    {
        return true;
    }
    return false;
}
