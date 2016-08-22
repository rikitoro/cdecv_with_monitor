#ifndef DBG_H_
#define DBG_H_

int dbg(const char dbg_addr);
int dbg_PC();
int dbg_A();
int dbg_B();
int dbg_C();
int dbg_T();
int dbg_R();
int dbg_FLG();
int dbg_Xbus();
int dbg_MA();
int dbg_WD();
int dbg_RD();
int dbg_I();
int dbg_xsrc();
int dbg_xdst();
int dbg_aluop();
int dbg_cycle_count();

int dbg_clock();
int dbg_we();
int dbg_end_sq();


#endif /* DBG_H_ */
