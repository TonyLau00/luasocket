# luasocket makefile
#
# see src/makefile for description of how to customize the build
#
# Targets:
#   install            install system independent support
#   install-unix           also install unix-only support
#   install-both       install for lua51 lua52 lua53
#   install-both-unix      also install unix-only
#   print	           print the build settings

PLAT?= linux
PLATS= macosx linux win32 win64 mingw freebsd solaris

# 定義靜態庫目標
STATIC_TARGET := socket/core.a mime/core.a

# 默認構建靜態庫
all: $(STATIC_TARGET)

# 靜態庫生成規則
$(STATIC_TARGET): $(OBJS)
    $(AR) rcs $@ $^
    $(RANLIB) $@


all: $(PLAT)

$(PLATS) none install install-unix local clean:
    $(MAKE) -C src $@

print:
    $(MAKE) -C src $@

test:
    lua test/hello.lua

install-static:
    $(MAKE) -C src $(PLAT) STATIC=1
    $(MAKE) -C src install-static

install-both:
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.1 STATIC=1
    @cd src; $(MAKE) install-static LUAV=5.1
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.2 STATIC=1
    @cd src; $(MAKE) install-static LUAV=5.2
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.3 STATIC=1
    @cd src; $(MAKE) install-static LUAV=5.3
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.4 STATIC=1
    @cd src; $(MAKE) install-static LUAV=5.4

install-both-unix:
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.1 STATIC=1
    @cd src; $(MAKE) install-unix LUAV=5.1
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.2 STATIC=1
    @cd src; $(MAKE) install-unix LUAV=5.2
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.3 STATIC=1
    @cd src; $(MAKE) install-unix LUAV=5.3
    $(MAKE) clean
    @cd src; $(MAKE) $(PLAT) LUAV=5.4 STATIC=1
    @cd src; $(MAKE) install-unix LUAV=5.4

.PHONY: test