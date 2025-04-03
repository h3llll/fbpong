#include "utils.h"
#include "sys.h"

size_t str_length(const char *str) {
    const char *s = str;
    while (*s) s++;  // Move pointer until '\0' is found
    return s - str;  // Compute length
}

void println(int fd, const char *str)
{
    sys_write(fd, str, str_length(str));
    sys_write(fd, "\n", 1);
}
