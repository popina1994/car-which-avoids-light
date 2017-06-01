#ifndef _WHEEL_LEFT_H_
#define _WHEEL_LEFT_H_

extern int wheelLeftCurrentDuty;
static const int WHEEL_LEFT_FREQUENCY_PERIOD = 33;

void wheelLeftInit(const int unsigned int);

// @ref wheelLeftInit should be called before calling this method.
//
void wheelLeftStart();

void wheelLeftStop();

#endif
