#include "peripheral_driver/dbg.h"
#include "utility/hexformat.h"
#include "memory_data.h"

#include "debug_data.h"

void debugdata16_to_hexformat(const int dbg_data, char* hf) {
  MemoryData md;
  md.bytecount = 2;
  md.address = 0;
  md.recordtype = DATA_TYPE;
  md.data[0] = (0xff00 & dbg_data) >> 8;
  md.data[1] = 0xff & dbg_data;
  memorydata_to_hexformat(&md, hf);
}

void debugdata8_to_hexformat(const int dbg_data, char* hf) {
  MemoryData md;
  md.bytecount = 1;
  md.address = 0;
  md.recordtype = DATA_TYPE;
  md.data[0] = 0xff & dbg_data;
  memorydata_to_hexformat(&md, hf);
}

