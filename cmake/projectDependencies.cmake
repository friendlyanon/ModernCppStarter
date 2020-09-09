# top level dependencies go here

# fmt

CPMAddPackage(
  NAME fmt
  VERSION 7.0.3
  URL https://github.com/fmtlib/fmt/releases/download/7.0.3/fmt-7.0.3.zip
  # {fmt} doesn't support CPM.cmake so we configure it ourselves
  DOWNLOAD_ONLY YES
)

if(fmt_ADDED)
  file(GLOB fmt_sources "${fmt_SOURCE_DIR}/src/*.cc")
  add_library(fmt STATIC ${fmt_sources})

  target_include_directories(fmt PUBLIC "$<BUILD_INTERFACE:${fmt_SOURCE_DIR}/include>")

  # {fmt} needs C++ 11 at least to compile and use as a library
  target_compile_features(fmt PUBLIC cxx_std_11)

  # Don't want {fmt} source files to compile with GNU extensions
  set_target_properties(fmt PROPERTIES CXX_EXTENSIONS OFF)
else()
  message(FATAL_ERROR "Failed to add the fmt library")
endif()

# gsl

CPMAddPackage(
  NAME GSL
  GITHUB_REPOSITORY microsoft/GSL
  VERSION 3.1.0
  # GSL leaves some junk with set()s
  DOWNLOAD_ONLY YES
)

if(GSL_ADDED)
  add_library(GSL INTERFACE)

  target_include_directories(GSL INTERFACE "$<BUILD_INTERFACE:${GSL_SOURCE_DIR}/include>")

  # GSL uses C++ 14 by default in its CMakeLists file, so we propagate that requirement
  target_compile_features(GSL INTERFACE cxx_std_14)
else()
  message(FATAL_ERROR "Failed to add the GSL library")
endif()
