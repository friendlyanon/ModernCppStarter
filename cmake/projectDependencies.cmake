# top level dependencies go here

# fmt

CPMAddPackage(
  NAME fmt
  VERSION 7.0.3
  URL https://github.com/fmtlib/fmt/releases/download/7.0.3/fmt-7.0.3.zip
  # {fmt} doesn't support CPM.cmake so we configure it ourselves
  DOWNLOAD_ONLY YES
)

fail_if_not_added(fmt)

file(GLOB fmt_sources CONFIGURE_DEPENDS "${fmt_SOURCE_DIR}/src/*.cc")
add_library(fmt ${fmt_sources})

target_include_directories(fmt SYSTEM PUBLIC "$<BUILD_INTERFACE:${fmt_SOURCE_DIR}/include>")

# {fmt} needs C++ 11 at least to compile and use as a library
target_compile_features(fmt PUBLIC cxx_std_11)

# Don't want {fmt} source files to compile with GNU extensions
set_target_properties(fmt PROPERTIES CXX_EXTENSIONS OFF)

# Install {fmt}, because it has build artifacts
packageProject(
  NAME "fmt"
  VERSION "7.0.3"
  BINARY_DIR "${fmt_BINARY_DIR}"
  INCLUDE_DIR "${fmt_SOURCE_DIR}/include"
  INCLUDE_DESTINATION "include/fmt-7.0.3"
)

# gsl

CPMAddPackage(
  NAME GSL
  GITHUB_REPOSITORY microsoft/GSL
  VERSION 3.1.0
  # GSL leaves some junk with set()s
  DOWNLOAD_ONLY YES
)

fail_if_not_added(GSL)

add_library(GSL INTERFACE)

target_include_directories(GSL SYSTEM INTERFACE "$<BUILD_INTERFACE:${GSL_SOURCE_DIR}/include>")

target_compile_features(GSL INTERFACE cxx_std_17)

target_compile_definitions(GSL INTERFACE GSL_USE_STD_BYTE=1)
