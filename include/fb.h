#ifndef FB_H
#define FB_H

#define FBIOGET_VSCREENINFO 	17920
#define FBIOPUT_VSCREENINFO 	17921
#define FBIOGET_FSCREENINFO 	17922
#define FBIOPUT_FSCREENINFO 	17923
#define FBIOGETCMAP	            17924
#define FBIOPUTCMAP	            17925
#define FBIOPAN_DISPLAY	        17926

typedef struct fb_fix_screeninfo
{
	char id[16];
	unsigned int smem_start, smem_len, type, type_aux, visual, xpanstep,
		ypanstep, ywrapstep, line_length, mmio_start, mmio_len, accel;
} fb_fix_screeninfo;

typedef struct fb_var_screeninfo
{
	unsigned int xres, yres, xres_virtual, yres_virtual, xoffset, yoffset,
		bits_per_pixel, grayscale, red, green, blue, transp, nonstd, activate,
		height, width, accel_flags, pixclock, left_margin, right_margin,
		upper_margin, lower_margin, hsync_len, vsync_len, sync, vmode, rotate,
		colorspace, reserved[4];
} fb_var_screeninfo;

#endif // FB_H
