#ifndef _MOVEMENT_H_
#define _MOVEMENT_H_

#include "../../util/util.h"

static const int MAX_MOVE_CIRCLE = 440;
static const int MAX_MOVE_CIRCLE_HALF = MAX_MOVE_CIRCLE / 2;
static const int MAX_MOVE_BACK = 50;

static const int MOVE_MODE_FORWARD = 0;
static const int MOVE_MODE_CIRCLE = 1;
static const int MOVE_MODE_SEARCH_LIGHT = 2;

extern bool isPWMInitialized;
extern bool isStarted;
extern unsigned int moveMode;
extern int stepCnt;
extern int stepCntToDark;


void modeStart(void);
void modeChange(int newMode);
void detectionStart(void);
void timerTicked(void);


#endif
