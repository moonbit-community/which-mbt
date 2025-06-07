#include "moonbit.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int get_platform(void)
{

#ifdef _WIN32
    return 1;
#elif __linux__
    return 2;
#elif __APPLE__
    return 3;
#endif
    return 4;
}