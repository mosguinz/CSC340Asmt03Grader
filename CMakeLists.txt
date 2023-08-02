cmake_minimum_required(VERSION 3.24)
project(Asmt03Grader)

set(CMAKE_CXX_STANDARD 17)

FILE(GLOB sources *.*)
add_executable(Asmt03Grader ${sources})
