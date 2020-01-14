cmake_minimum_required(VERSION 2.8)

if (NOT CMAKE_BUILD_TYPE)
  #set(CMAKE_BUILD_TYPE Debug)
  set(CMAKE_BUILD_TYPE Release)
  #set(CMAKE_BUILD_TYPE RelWithDebInfo)
endif ()

if (NOT CMAKE_POSITION_INDEPENDENT_CODE)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif ()

if (NOT BUILD_SHARED_LIBS)
  set(BUILD_SHARED_LIBS ON)
endif ()

project(motiondetect C CXX)


set(LIB ${PROJECT_NAME})

add_definitions(-std=c99 -DHAVE_CONFIG_H -D__PLUGIN__ -DMODULE_STRING=\"${LIB}\")

file(GLOB src_files
   src/*.c
)

set(vlc_PATH ${PROJECT_SOURCE_DIR}/../install/)
set(vlc_INCLUDES ${vlc_PATH}/include/vlc ${vlc_PATH}/include/vlc/plugins)
set(vlc_LIBRARIES ${vlc_PATH}/lib/libvlc.so ${vlc_PATH}/lib/libvlccore.so)

add_library(${LIB} ${src_files})
target_include_directories(${LIB} PUBLIC ${vlc_INCLUDES} src)
target_link_libraries(${LIB} ${vlc_LIBRARIES})
