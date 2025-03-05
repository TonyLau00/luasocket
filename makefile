OBJS = src/luasocket.o src/timeout.o src/buffer.o src/io.o src/auxiliar.o src/options.o src/inet.o src/except.o src/select.o src/tcp.o src/udp.o src/compat.o

LUAINC = -I/usr/include/lua5.4

STATIC_TARGET := socket/core.a mime/core.a

all: $(STATIC_TARGET)

$(STATIC_TARGET): $(OBJS)
	$(AR) rcs $@ $^
	$(RANLIB) $@

clean:
	rm -f $(OBJS) $(STATIC_TARGET)

$(PLATS) none install install-unix local:
	$(MAKE) -C src $@
print:
	$(MAKE) -C src $@
test:
	lua test/hello.lua
.PHONY: all clean test