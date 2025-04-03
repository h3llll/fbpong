#include "fb.h"
#include "sys.h"
#include "utils.h"

struct pixel
{
	size_t pos_x, pos_y;
	unsigned int color;
};

typedef struct pixel pixel;

int main(void)
{
	println(stdout, "funny assembly");

	fd fd = sys_openat(AT_FDCWD, "/dev/fb0", O_RDWR, 0);
	if (fd < 0)
	{
		println(stderr, "Failed to open /dev/fb0");
		sys_exit(EXIT_FAILURE);
	}

	struct fb_var_screeninfo info;
	int ioctl_ret = sys_ioctl(fd, FBIOGET_VSCREENINFO, &info);
	if (ioctl_ret < 0)
	{
		println(stderr, "Failed to get fb_var_screeninfo (sys_ioctl failed)");
		sys_exit(EXIT_FAILURE);
	}

	size_t len = 4 * info.xres * info.yres;

	void *buf = sys_mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
	if (buf == MAP_FAILED)
	{
		println(stderr, "Failed to map memory (mmap failed)");
		sys_exit(EXIT_FAILURE);
	}

	pixel pixel = {.pos_x = 100, .pos_y = 100, .color = 0xFFFF0000};

	size_t offset = (pixel.pos_y * info.xres + pixel.pos_x) * 4;
	
    memcpy((unsigned char *)buf + offset, &pixel.color, sizeof(unsigned int));
	
    return EXIT_SUCCESS;
}
