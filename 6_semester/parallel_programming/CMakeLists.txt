cmake_minimum_required(VERSION 3.16)

project(app)

#SET(CMAKE_CXX_FLAGS "-O3")

include_directories (
    ./src/
) 

add_executable(
    ${PROJECT_NAME}
    ./src/multiply.cpp
    ./src/main.cpp
    ./src/test.cpp 
    ./src/lib.cpp
    ./src/print.cpp
    ./src/poly.cpp
    ./src/dft.cpp
    ./src/fft.cpp
)

