cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)

project(mcpp)

if(DEFINED ENV{VCPKG_ROOT} AND NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
        CACHE STRING "")
    include(${CMAKE_TOOLCHAIN_FILE})
endif()

find_package(Boost REQUIRED)
#if (Boost_LIBRARIES STREQUAL "")
#    set(Boost_LIBRARIES 
#    )
#endif() 

set(MCPP_HEADERS
    dumps.hxx
)

set(MCPP_SRCS 
    main.cxx
    template_type_deduction.cxx
)

add_executable(${PROJECT_NAME} ${MCPP_HEADERS} ${MCPP_SRCS})

set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 20)

target_include_directories(${PROJECT_NAME} PRIVATE 
    ${Boost_INCLUDE_DIRS}
)

target_compile_options(${PROJECT_NAME} PRIVATE 
)

#target_link_libraries(${PROJECT_NAME} PRIVATE ${Boost_LIBRARIES})

message(STATUS "=======================================================")
message(STATUS "Boost ver  : ${Boost_VERSION}")
message(STATUS "Boost incs : ${Boost_INCLUDE_DIRS}")
message(STATUS "Boost libs : ${Boost_LIBRARIES}")
message(STATUS "=======================================================")
