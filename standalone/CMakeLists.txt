cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(GreeterStandalone LANGUAGES CXX)

# ---- Import tools ----

include(../cmake/tools.cmake)
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

CPMAddPackage(
  NAME cxxopts
  GITHUB_REPOSITORY jarro2783/cxxopts
  VERSION 2.2.0
  OPTIONS "CXXOPTS_BUILD_EXAMPLES Off" "CXXOPTS_BUILD_TESTS Off"
)

CPMAddPackage(NAME Greeter SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

# ---- Create standalone executable ----

file(GLOB sources CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/source/*.cpp)

add_executable(GreeterStandalone ${sources})

set_target_properties(
  GreeterStandalone
  PROPERTIES CXX_STANDARD 17
             CXX_EXTENSIONS OFF
             OUTPUT_NAME "Greeter"
)

target_link_libraries(GreeterStandalone Greeter cxxopts fmt GSL)

set_project_warnings(GreeterStandalone)
