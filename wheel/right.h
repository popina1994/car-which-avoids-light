#ifndef _WHEEL_RIGHT_H_
#define _WHEEL_RIGHT_H_

extern int wheelRightCurrentDuty;
static const int WHEEL_RIGHT_FREQUENCY_PERIOD = 50;

void wheelRightInit(const unsigned int maxGears);

// @ref wheelRightInit should be called before calling this method.
//
void wheelRightStart();

void wheelRightStop();

#endif
