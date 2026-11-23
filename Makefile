# Modern Ludo Game - build file
# Linux/macOS :  make
# Windows (w64devkit / MinGW):  make   (set RAYLIB_PATH if raylib is elsewhere)

CC      ?= gcc
CFLAGS  := -std=c11 -O2 -Wall
SRC     := src/main.c

ifeq ($(OS),Windows_NT)
    RAYLIB_PATH ?= C:/raylib/raylib/src
    TARGET  := ludo.exe
    CFLAGS  += -I$(RAYLIB_PATH)
    LDFLAGS := -L$(RAYLIB_PATH) -lraylib -lopengl32 -lgdi32 -lwinmm -lws2_32
else
    TARGET  := ludo
    CFLAGS  += $(shell pkg-config --cflags raylib)
    LDFLAGS := $(shell pkg-config --libs raylib) -lm
endif

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET) $(LDFLAGS)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f ludo ludo.exe

.PHONY: all run clean
