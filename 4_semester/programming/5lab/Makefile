COMPILER = g++
INCLUDE_PATH = \
			./include \
			./include/wndproc \
			./include/window \
			
OBJ_PATH = obj
BIN_PATH = bin
SRC_PATH = src

CFLAGS = -Wall $(INCLUDE_PATH:%=-I%)

ADD_DIRS = window\
		  wndproc\
		  app \
		  asm \


TEST_FILES = test/graph_test.cpp \

TEST_DIRS = $(dir $(TEST_FILES))

DLL_DIRS = $(ADD_DIRS:%=$(SRC_PATH)/%)
SRC_FILES = $(wildcard $(addsuffix /*.cpp, $(DLL_DIRS)))
OBJ_FILES = $(patsubst %,$(OBJ_PATH)/%,$(notdir $(SRC_FILES:%.cpp=%.o)))

SRC_FILES_TEST = $(wildcard $(TEST_FILES))
OBJ_FILES_TEST = $(patsubst %,$(OBJ_PATH)/%,$(notdir $(SRC_FILES_TEST:%.cpp=%.o)))

all: $(BIN_PATH)/app.dll $(BIN_PATH)/lab5.exe $(BIN_PATH)/graph.dll

$(BIN_PATH)/lab5.exe:
	$(COMPILER) $(CFLAGS) $(BIN_PATH)/app.dll  src/main.cpp -o $(BIN_PATH)/lab5.exe 


$(BIN_PATH)/app.dll: $(OBJ_FILES) obj/graph.o
	$(COMPILER) $^ -o $(BIN_PATH)/app.dll -shared

vpath %.cpp $(DLL_DIRS)

$(OBJ_PATH)/%.o: %.cpp 
	$(COMPILER) $(CFLAGS) -c -DBUILD_DLL $< -o $@

$(BIN_PATH)/graph.dll: 
	nasm -fwin32 src/asm/graph.asm -o obj/graph.obj
	$(COMPILER) obj/graph.obj -o $(BIN_PATH)/graph.dll -shared

test: $(BIN_PATH)/test
	$(BIN_PATH)/test

$(BIN_PATH)/test: $(OBJ_FILES_TEST) obj/graph.o obj/graph.obj
	$(COMPILER) $^ -o $(BIN_PATH)/test

vpath %.cpp $(TEST_DIRS)


clean:
	rm -rf ./obj/*.o

run:
	bin/lab5.exe
