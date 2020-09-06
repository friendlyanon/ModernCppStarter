if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
  option(ENABLE_BUILD_WITH_TIME_TRACE
         "Enable -ftime-trace to generate time tracing .json files on clang" OFF
  )
endif()

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'RelWithDebInfo' as none was specified.")
  set(CMAKE_BUILD_TYPE
      RelWithDebInfo
      CACHE STRING "Choose the type of build." FORCE
  )
  # Set the possible values of build type for cmake-gui, ccmake
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release MinSizeRel RelWithDebInfo)
endif()

function(set_project_options TARGET)
  set_target_properties("${TARGET}" PROPERTIES CXX_STANDARD 17 CXX_EXTENSIONS OFF)

  if(ENABLE_BUILD_WITH_TIME_TRACE)
    add_compile_definitions("${TARGET}" INTERFACE -ftime-trace)
  endif()
endfunction()
