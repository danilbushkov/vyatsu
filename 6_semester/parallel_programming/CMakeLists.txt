cmake_minimum_required(VERSION 3.16)

project(app)

SET(CMAKE_CXX_FLAGS "-O2")
SET(CMAKE_CXX_FLAGS "-pthread")
SET(CMAKE_CXX_FLAGS "-fopenmp")

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
    ./src/pfft.cpp
    ./src/omp_fft.cpp
)

