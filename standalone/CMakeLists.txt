cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(GreeterStandalone LANGUAGES CXX)

# --- Import tools ----

include(../cmake/tools.cmake)
include(../cmake/warnings.cmake)

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

set_target_properties(GreeterStandalone PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "Greeter")

target_link_libraries(GreeterStandalone Greeter cxxopts)

set_project_warnings(GreeterStandalone)

if(USE_STATIC_LINKAGE)
  if(MSVC)
    option(PROJECT_USES_MFC "Does the project use MFC?" OFF)
    if(PROJECT_USES_MFC)
      set(CMAKE_MFC_FLAG 1)
    endif()

    set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")

    target_compile_options(GreeterStandalone PUBLIC /MT)

    target_link_options(GreeterStandalone PUBLIC /INCREMENTAL:NO /NODEFAULTLIB:MSVCRT)
  else()
    target_link_libraries(GreeterStandalone -static)
  endif()
endif()
