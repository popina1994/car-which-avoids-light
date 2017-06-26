#ifndef _BLUETOOTH_H_
#define _BLUETOOTH_H_

#include "../util/util.h"

static const unsigned int BLUETOOTH_TIME_DELAY_MS = 1000;
static const unsigned int OUTPUT_BUFFER_SIZE = 256;
static const unsigned int BAUD_RATE = 9600;

#define UART_TYPE 3
#define BLUETOOTH_PIN_NAME D
#define BLUETOOTH_PIN_TRANSMIT_IDX 8
#define BLUETOOTH_PIN_RECIEVE_IDX 9

#define UART_INIT_ADVANCED CONCAT_EXP(CONCAT_EXP(UART, UART_TYPE),_Init_Advanced)
#define UART_ENABLE CONCAT_EXP(CONCAT_EXP(UART, UART_TYPE),_Enable)
#define UART_WRITE_TEXT CONCAT_EXP(CONCAT_EXP(UART, UART_TYPE),_Write_Text)
#define UART_TX_IDLE CONCAT_EXP(CONCAT_EXP(UART, UART_TYPE),_Tx_Idle)
#define UART_MODULE_PIN_TR_RC                                                       \
            CONCAT_EXP(CONCAT_EXP(CONCAT_EXP(_GPIO_MODULE_USART, UART_TYPE),        \
                CONCAT_EXP(_P, BLUETOOTH_PIN_NAME)),                                \
                CONCAT_EXP(BLUETOOTH_PIN_TRANSMIT_IDX, BLUETOOTH_PIN_RECIEVE_IDX))


void bluetoothInit();

void stringSendViaBluetooth(const char* str);

void intSendIntViaBluetooth(int val);

bool isBluetoothReadyForTransmission();

#endif