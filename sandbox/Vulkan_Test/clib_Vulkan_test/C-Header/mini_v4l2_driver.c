#include "v4l2_driver.h"
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <linux/videodev2.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int IMAGE_WIDTH = 640;
int IMAGE_HEIGHT = 480;

#define BUF_NUM 4

// set format
int v4l2_sfmt(int fd, uint32_t pfmt) {
  // set fmt
  struct v4l2_format fmt;
  fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
  fmt.fmt.pix.pixelformat = pfmt;
  fmt.fmt.pix.height = IMAGE_HEIGHT;
  fmt.fmt.pix.width = IMAGE_WIDTH;
  fmt.fmt.pix.field = V4L2_FIELD_INTERLACED;

  if (ioctl(fd, VIDIOC_S_FMT, &fmt) == -1) {
    fprintf(stderr, "Unable to set format\n");
    return -1;
  }
  return 0;
}

// get format
int v4l2_gfmt(int fd) {
  // set fmt
  struct v4l2_format fmt;
  if (ioctl(fd, VIDIOC_G_FMT, &fmt) == -1) {
    fprintf(stderr, "Unable to get format\n");
    return -1;
  }
  printf("\033[33mpix.pixelformat:\t%c%c%c%c\n\033[0m",
         fmt.fmt.pix.pixelformat & 0xFF, (fmt.fmt.pix.pixelformat >> 8) & 0xFF,
         (fmt.fmt.pix.pixelformat >> 16) & 0xFF,
         (fmt.fmt.pix.pixelformat >> 24) & 0xFF);
  printf("pix.height:\t\t%d\n", fmt.fmt.pix.height);
  printf("pix.width:\t\t%d\n", fmt.fmt.pix.width);
  printf("pix.field:\t\t%d\n", fmt.fmt.pix.field);
  return 0;
}

