cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(DiffLiDAR)

find_package(PCL 1.2 REQUIRED)
find_package(OpenMP)

include_directories(${PCL_INCLUDE_DIRS})
link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

if(OPENMP_FOUND)
 set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
 set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
 set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}") 
endif()

add_executable (DiffLiDAR DiffLiDAR.cpp)
target_link_libraries (DiffLiDAR ${PCL_LIBRARIES})

