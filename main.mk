# Setting the default goal to "all" is important because foobar.mk
# (referenced below) defines several targets, the first of which would
# otherwise become the default because "make" will encounter it before
# any other target.
.DEFAULT_GOAL := all

CFLAGS := -g -O0 -pedantic -pipe -Wall -Werror

INCDIRS := .

SUBMAKEFILES := \
    app/app.mk \
    foobar.mk # Has rules to build the external project
