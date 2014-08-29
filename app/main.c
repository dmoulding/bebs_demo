#define _POSIX_C_SOURCE 200112L

#include <stdio.h>
#include <stdlib.h>

#include <foobar/foo.h>
#include <foobar/bar.h>

int main (int argc, char *argv [])
{
    print_foo();
    print_bar();
    printf("\n");

    return EXIT_SUCCESS;
}
