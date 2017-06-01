#ifndef _BLUETOOTH_H_
#define _BLUETOOTH_H_

#include "../util/util.h"

static const unsigned int BLUETOOTH_TIME_DELAY_MS = 1000;
static const unsigned int OUTPUT_BUFFER_SIZE = 256;

void bluetoothInit();

void stringSendViaBluetooth(const char* str);

void intSendIntViaBluetooth(int val);

bool isBluetoothReadyForTransmission();

#endif
