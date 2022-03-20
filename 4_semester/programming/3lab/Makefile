COMPILER = g++
INCLUDE_PATH = ./include
OBJ_PATH = obj
BIN_PATH = bin
SRC_PATH = src

CFLAGS = -c -Wall -I$(INCLUDE_PATH)

SRC_FILES = main.cpp \
			MainWindow.cpp \
			Window.cpp \

OBJ_FILES = $(SRC_FILES:%.cpp=$(OBJ_PATH)/%.o)


all: $(BIN_PATH)/lab3

$(BIN_PATH)/lab3: $(OBJ_FILES)
	$(COMPILER) $(OBJ_FILES) -o $(BIN_PATH)/lab3

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.cpp
	$(COMPILER) $(CFLAGS) -c $< -o $@
	

clean:
	rm -rf ./obj/*.o