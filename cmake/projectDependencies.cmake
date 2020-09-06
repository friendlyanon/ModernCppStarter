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

  target_include_directories(fmt PUBLIC "${fmt_SOURCE_DIR}/include")

  set_target_properties(fmt PROPERTIES CXX_STANDARD 17 CXX_EXTENSIONS OFF)
else()
  message(FATAL_ERROR "-- Failed to add the fmt library")
endif()
