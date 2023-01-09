#--param large-function-growth=800 \
#--param inline-unit-growth=200 \

MAKEFLAGS += --no-builtin-rules
MAKE = /usr/bin/make
CFILES := \
	./emscripten.c \
	./emu/antic.c \
	./emu/atari.c \
	./emu/atari_nds.c \
	./emu/binload.c \
	./emu/cartridge.c \
	./emu/cassette.c \
	./emu/compfile.c \
	./emu/cpu.itcm.c \
	./emu/devices.c \
	./emu/gtia.c \
	./emu/input.c \
	./emu/memory.c \
	./emu/pbi.c \
	./emu/pia.c \
	./emu/pokey.c \
	./emu/pokeysnd.c \
	./emu/rtime.c \
	./emu/screen.c \
	./emu/sio.c \
	./emu/sound_nds.c \
	./emu/statesav.c \
	./emu/util.c

FILES := $(patsubst %.c,%.o,$(CFILES))

FLAGS := \
	-O3 \
    $(CFLAGS) \
	-I. \
    -I./emu \
    -DWRC \
	-DSOUND \
  	-Winline \
  	-fomit-frame-pointer \
	-fno-strict-overflow \
	-fsigned-char \
  	-Wno-strict-aliasing \
  	-Wno-narrowing \
    -flto

LINK_FLAGS := \
    -O3 \
	-lz \
    -s MODULARIZE=1 \
    -s EXPORT_NAME="'a5200'" \
    -s TOTAL_MEMORY=67108864 \
    -s ALLOW_MEMORY_GROWTH=1 \
	-s ASSERTIONS=0 \
	-s EXIT_RUNTIME=0 \
	-s EXPORTED_RUNTIME_METHODS="['FS', 'cwrap']" \
    -s EXPORTED_FUNCTIONS="['_emInit', '_emStep', '_emSetInput']" \
	-s INVOKE_RUN=0 \
    -flto

all: a5200

a5200:
	@echo colem
	$(MAKE) a5200.js

a5200.js: $(FILES)
	emcc -o $@ $(FILES) $(LINK_FLAGS)

%.o : %.cpp
	emcc -c $< -o $@ \
	$(FLAGS)

%.o : %.c
	emcc -c $< -o $@ \
	$(FLAGS)

clean:
	@echo "Cleaning"
	@echo $(FILES)
	rm -fr *.o */*.o */*/*.o */*/*/*.o */*/*/*/*.o
