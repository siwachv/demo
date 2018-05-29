DRIVER_DIR = ../cpp-driver
TARGET = collectorCC
CC = gcc
CFLAGS+= -g -Wall -D_CUSTOM_DIAG_HEADER__ -DGET_BBR_INFO -I../librdkafka/src -I$(DRIVER_DIR)/include

# Shouldn't system libs like -ldl and -lrt come last in the list?
LDFLAGS += -L. -Wl,-rpath-link,-L/usr/local/lib -L./lib -Wl,-R/usr/local/lib -lz -lpthread -lrt -lmnl -lcassandra -lrdkafka

all: stats-collector
#
stats-collector: collectorCC.o 
	$(CC) -o $@ collectorCC.o $(LDFLAGS) 
#
%.i:%.c
	$(CC) $(CFLAGS) -E -o $@ $<

%.o:%.i
	$(CC) $(CFLAGS) -o $@ $<

install: /usr/local/lib/stats-collector
	cp $< $@

/usr/local/lib/stats-collector: stats-collector
	cp $< /usr/local/lib
clean:
	rm -f stats-collector
#       we need *.so in case libraries are renamed - we don't want the old libs lying around
	rm -f *.o *.so
