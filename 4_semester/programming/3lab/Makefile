COMPILER = g++
INCLUDE_PATH = \
			./include \
			./include/wndproc \
			./include/window \
			
OBJ_PATH = obj
BIN_PATH = bin
SRC_PATH = src

CFLAGS = -c -Wall $(INCLUDE_PATH:%=-I%)

ADD_DIRS = window\
		  wndproc\


SRC_DIRS = $(SRC_PATH)  $(ADD_DIRS:%=$(SRC_PATH)/%)

SRC_FILES = $(wildcard $(addsuffix /*.cpp, $(SRC_DIRS)))

OBJ_FILES = $(patsubst %,$(OBJ_PATH)/%,$(notdir $(SRC_FILES:%.cpp=%.o)))


all: $(BIN_PATH)/lab3

$(BIN_PATH)/lab3: $(OBJ_FILES)
	$(COMPILER) $^ -o $(BIN_PATH)/lab3

vpath %.cpp $(SRC_DIRS)

$(OBJ_PATH)/%.o: %.cpp
	$(COMPILER) $(CFLAGS) -c $< -o $@



clean:
	rm -rf ./obj/*.o

