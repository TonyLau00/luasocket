OBJS = src/luasocket.o src/timeout.o src/buffer.o src/io.o src/auxiliar.o src/options.o src/inet.o src/except.o src/select.o src/tcp.o src/udp.o src/compat.o

LUAINC = -I/usr/include/lua5.4

# 定義靜態庫目標
STATIC_TARGET := socket/core.a mime/core.a

# 默認構建靜態庫
all: $(STATIC_TARGET)

# 靜態庫生成規則
$(STATIC_TARGET): $(OBJS)
	$(AR) rcs $@ $^
	$(RANLIB) $@

# 清理規則
clean:
	rm -f $(OBJS) $(STATIC_TARGET)

# 其他目標
$(PLATS) none install install-unix local:
	$(MAKE) -C src $@

print:
	$(MAKE) -C src $@

test:
	lua test/hello.lua

.PHONY: all clean test