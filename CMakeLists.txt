cmake_minimum_required (VERSION 2.8)

project(pceas)

# Force build type to Debug if none was specified.
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif(NOT CMAKE_BUILD_TYPE)

if(CMAKE_BUILD_TYPE MATCHES "Debug")
    add_definitions( -DDEBUG )
endif(CMAKE_BUILD_TYPE MATCHES "Debug")

set(pceas_MAJOR_VERSION 3)
set(pceas_MINOR_VERSION 22)
set(VERSION "${pceas_MAJOR_VERSION}.${pceas_MINOR_VERSION}")

set(LIBRARY_OUTPUT_PATH    "${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}")
set(EXECUTABLE_OUTPUT_PATH "${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}")
set(ARCHIVE_OUTPUT_PATH    "${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}")

set(PROJECT_NAME pceas)

set( pceas_SRC
    assemble.c
    code.c
    command.c
    crc.c
    expr.c
    func.c
    input.c
    macro.c
    main.c
    map.c
    mml.c
    nes.c
    output.c
    pce.c
    pcx.c
    proc.c
    symbol.c
)

configure_file(
    ${PROJECT_SOURCE_DIR}/version.h.in
    ${PROJECT_SOURCE_DIR}/version.h
)

add_executable( ${PROJECT_NAME} ${pceas_SRC} )
