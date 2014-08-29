TARGET := bin/app
TGT_LDFLAGS := -L foobar
TGT_LDLIBS := -lfoo -lbar

# The following prerequisites refer to real files output by the
# external build system.
TGT_PREREQS := foobar/libfoo.a foobar/libbar.a

SRC_CFLAGS := -std=c99

SOURCES := main.c
