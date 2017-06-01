
#ifndef _TIMER_H_
#define _TIMER_H_
//                                          5ms       20ms           50ms      100ms    200ms        500ms
static const unsigned TIMER3_PRESCALER[] = {       9,        39,            95,       191,     374,         959   };
static const unsigned TIMER3_ARR[] = {       59999,    59999,         62499,    62499,   63999,       62499   };
static const unsigned int TIMER3_INTERRUPT_MODE = 2;

void timer3Init();
#endif
