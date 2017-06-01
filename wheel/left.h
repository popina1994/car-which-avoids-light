#ifndef _WHEEL_LEFT_H_
#define _WHEEL_LEFT_H_

extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftStart();

// @ref wheelLeftInit should be called before calling this method.
//
void wheelLeftInit();

void wheelLeftStop();

#endif
