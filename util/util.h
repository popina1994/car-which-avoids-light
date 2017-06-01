#ifndef  _UTIL_H_
#define _UTIL_H_

#define DEBUG 1

#define bool char
#define true 1
#define false 0

#define CONCAT_NOT_EXP(A, B) A ## B
#define CONCAT_EXP(A, B) CONCAT_NOT_EXP(A, B)
#define CONCAT_SPECIAL(A, B) A B

#define PIN_NAME_EXP(PIN_TYPE) CONCAT_EXP(CONCAT_EXP(GPIO, PIN_TYPE), _BASE)
#define PIN_IDX_EXP(PIN_IDX) CONCAT_EXP(_GPIO_PINMASK_, PIN_IDX)

#define INST_STANDBY asm wfi
#define CPU_DELAY_TIME_MS 100

#endif // !1
