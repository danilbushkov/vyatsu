cmake_minimum_required(VERSION 3.16)

project(app)


include_directories (
    ./src/
) 

add_executable(
    ${PROJECT_NAME}
    ./src/main.cpp

)

