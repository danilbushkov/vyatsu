SRC_PATH = src
OBJ_PATH = obj

ADD_DIRS = game \
			game/settings \
			game/game_objects \
			game/list

SRC_DIRS = $(ADD_DIRS:%=$(SRC_PATH)/%) $(SRC_PATH)

DLL_FILES = bin/sfml-graphics-2.dll \
			bin/sfml-system-2.dll \
			bin/sfml-window-2.dll \

INCLUDE_PATH = D:\lib\SFML-2.5.1\include \
				$(SRC_DIRS)

CFLAGS = -Wall $(INCLUDE_PATH:%=-I%)

SRC_FILES = $(wildcard $(addsuffix /*.cpp, $(SRC_DIRS)))
INCLUDE_FILES = $(wildcard $(addsuffix /*.h, $(SRC_DIRS)))


all: bin/game.exe

bin/game.exe: $(INCLUDE_FILES) $(SRC_FILES)
	g++ $(CFLAGS) $(SRC_FILES) $(DLL_FILES) -o bin/game.exe 
	bin\game.exe




run:
	bin\game.exe