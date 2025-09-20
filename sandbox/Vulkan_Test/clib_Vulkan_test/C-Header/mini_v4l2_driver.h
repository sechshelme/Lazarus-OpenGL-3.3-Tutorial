#ifndef _V4l2_DRIVER__
#define _V4l2_DRIVER__

#include <inttypes.h>
#include <pthread.h>

extern int v4l2_sfmt(int fd, uint32_t pfmt);
extern int v4l2_gfmt(int fd);

#endif
