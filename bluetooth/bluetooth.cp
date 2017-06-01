#line 1 "C:/Users/popina/Documents/MIPS/bluetooth/bluetooth.c"
#line 1 "c:/users/popina/documents/mips/bluetooth/bluetooth.h"
#line 1 "c:/users/popina/documents/mips/bluetooth/../util/util.h"
#line 6 "c:/users/popina/documents/mips/bluetooth/bluetooth.h"
static const unsigned int BLUETOOTH_TIME_DELAY_MS = 1000;
static const unsigned int OUTPUT_BUFFER_SIZE = 256;

void bluetoothInit();

void stringSendViaBluetooth(const char* str);

void intSendIntViaBluetooth(int val);

 char  isBluetoothReadyForTransmission();
#line 3 "C:/Users/popina/Documents/MIPS/bluetooth/bluetooth.c"
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

 char  isBluetoothReadyForTransmission()
{
 if (UART3_Tx_Idle() == 1)
 {
 return  1 ;
 }
 return  0 ;
}
