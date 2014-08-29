ARFLAGS := -cruv
CFLAGS  := -g -O0 -pedantic -pipe -Wall -Werror

SUBMAKEFILES := \
    libfoo.mk \
    libbar.mk
