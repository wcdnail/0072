cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)

project(mcpp)

if(DEFINED ENV{VCPKG_ROOT} AND NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
        CACHE STRING "")
    include(${CMAKE_TOOLCHAIN_FILE})
endif()

find_package(Boost REQUIRED)

set(PCH
    stdafx.h
    stdafx.cxx
)

set(MCPP_HEADERS
    dumps.hxx
)

set(MCPP_SRCS 
    main.cxx
    template_type_deduction.cxx
    curve_brackets_init.cxx
    auto_generated_ctors.cxx
    unique_ptr_sizes.cxx
)

source_group("build" FILES 
    CMakeLists.txt
)

source_group("" FILES 
    ${MCPP_HEADERS} 
    ${MCPP_SRCS} 
    ${PCH}
)

if (MSVC)
    add_definitions(/Yustdafx.h)
    set_source_files_properties(stdafx.cxx PROPERTIES COMPILE_FLAGS /Ycstdafx.h)
endif()

add_executable(${PROJECT_NAME} ${MCPP_HEADERS} ${MCPP_SRCS} ${PCH})

set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 20)

target_include_directories(${PROJECT_NAME} PRIVATE 
    ${Boost_INCLUDE_DIRS}
)

target_compile_options(${PROJECT_NAME} PRIVATE 
)

target_link_libraries(${PROJECT_NAME} PRIVATE
)

message(STATUS "=======================================================")
message(STATUS "Boost ver  : ${Boost_VERSION}")
message(STATUS "Boost incs : ${Boost_INCLUDE_DIRS}")
message(STATUS "=======================================================")

if (MSVC)
    set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})
endif()
