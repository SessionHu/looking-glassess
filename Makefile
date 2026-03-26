DC = $(shell command -v ldc2 || command -v dmd)
ifeq ($(DC),)
$(error "No D compiler found. Please install LDC or DMD first! GDC is not supported yet.")
endif

ifeq ($(RELEASE),1)
CFLAGS = -O2 -flto=full
DFLAGS = -O2 -release -flto=full -Isrc
else
CFLAGS = -g
DFLAGS = -Isrc -g
endif

BUILD = build
DIST = dist
SRC = src

all: ${DIST}/cgi-bin/lgmain ${DIST}/index.html

${DIST}/cgi-bin/lgmain: ${BUILD}/lgmain.o ${BUILD}/ping.o ${BUILD}/trace.o ${BUILD}/kroute.o ${BUILD}/proto.o ${BUILD}/broute.o ${BUILD}/dig.o | ${DIST}/cgi-bin
	$(DC) $(DFLAGS) $^ -of=$@
ifeq ($(RELEASE),1)
	strip $@
endif

${BUILD}/%.o: ${SRC}/%.d | ${BUILD}
	$(DC) $(DFLAGS) -c $< -of=$@

${BUILD}/%.o: ${SRC}/%.c | ${BUILD}
	$(CC) $(CFLAGS) -c $< -o $@

${DIST}/index.html: ${SRC}/index.html
	cp $< $@

${BUILD}:
	mkdir -p $@

${DIST}:
	mkdir -p $@

${DIST}/cgi-bin:
	mkdir -p $@

clean:
	rm -rf ${BUILD} ${DIST}

setsuid: ${DIST}/cgi-bin/lgmain
	chown bird $<
	chmod +s $<

.PHONY: all clean
