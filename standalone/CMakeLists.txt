cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(GreeterStandalone LANGUAGES CXX)

# ---- Import tools ----

include(../cmake/tools.cmake)
# Import PROJECT_WARNINGS list variable
include(../cmake/warnings.cmake)

# ---- Build type ----

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'RelWithDebInfo' as none was specified.")
  set(CMAKE_BUILD_TYPE
      RelWithDebInfo
      CACHE STRING "Choose the type of build." FORCE
  )
  # Set the possible values of build type for cmake-gui, ccmake
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release MinSizeRel RelWithDebInfo)
endif()

# ---- Dependencies ----

include(../cmake/CPM.cmake)

# cxxopts

CPMAddPackage(
  NAME cxxopts
  GITHUB_REPOSITORY jarro2783/cxxopts
  VERSION 2.2.0
  # Breaks with warnings on otherwise
  DOWNLOAD_ONLY YES
)

fail_if_not_added(cxxopts)

add_library(cxxopts INTERFACE)

target_include_directories(
  cxxopts SYSTEM INTERFACE "$<BUILD_INTERFACE:${cxxopts_SOURCE_DIR}/include>"
)

target_compile_features(cxxopts INTERFACE cxx_std_11)

# root project

CPMAddPackage(
  NAME Greeter
  SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/.."
  OPTIONS "GREETER_INCLUDE_TYPE PUBLIC"
)

# ---- Create standalone executable ----

file(GLOB sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/source/*.cpp")

add_executable(GreeterStandalone ${sources})

set_target_properties(
  GreeterStandalone
  PROPERTIES CXX_STANDARD 17
             CXX_EXTENSIONS OFF
             OUTPUT_NAME "Greeter"
)

target_link_libraries(GreeterStandalone Greeter cxxopts fmt GSL)

target_compile_options(GreeterStandalone PRIVATE ${PROJECT_WARNINGS})
