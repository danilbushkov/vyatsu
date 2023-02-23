cmake_minimum_required(VERSION 3.16)     

project(app)  

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5Widgets REQUIRED)

set(INCLUDE_DIR ./src/)
include_directories(${INCLUDE_DIR})

add_executable(      
  ${PROJECT_NAME}                     
  ./src/main.cpp                               
  ./src/view.cpp
  
)     

qt5_use_modules(
  ${PROJECT_NAME} 
  Widgets
)

