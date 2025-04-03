#ifndef SYS_H
#define SYS_H

// Exit codes
#define EXIT_FAILURE -1
#define EXIT_SUCCESS 1

// NULL
#define     NULL        ((void *)0)

// File descriptors
#define     stdin           0
#define     stdout          1
#define     stderr          2
#define     AT_FDCWD        -100

// open flags
#define     O_RDONLY        0 // read only
#define     O_WRONLY        1 // write-only
#define     O_RDWR          2   // Open for both reading and writing

// mmap flags
#define     MAP_FAILED      ((void *) -1)
#define     MAP_SHARED      1
#define     MAP_PRIVATE     2
#define     MAP_FIXED       16
#define     MAP_ANONYMOUS   32
#define     MAP_NORESERVE   1024
#define     MAP_POPULATE    4096
#define     MAP_NONBLOCK    8192

// Memory protection flags
#define     PROT_READ       1
#define     PROT_WRITE	    2
#define     PROT_EXEC	    4
#define     PROT_NONE	    0

typedef     unsigned        long size_t;
typedef     int             fd;
typedef     long            long off_t;

extern size_t sys_write(fd fd, const char *buf, size_t count);

extern fd sys_openat(int dir_fd, const char *path, int flags, int mode);

extern void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
				  off_t offset);

extern int sys_munmap(void *addr, size_t length);

extern void *memcpy(void *dest, const void *src, size_t n);

extern int sys_ioctl(fd fd, unsigned long request, ...);

extern int sys_exit(int code);

#endif // SYS_H
