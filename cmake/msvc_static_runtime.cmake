
option(MSVC_STATIC_RUNTIME "Link with static msvc runtime libraries" ON)

if(MSVC_STATIC_RUNTIME)
  # switch from dynamic to static linking of msvcrt
  foreach(flag_var
    CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
    CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
    CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
    CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)

    if(${flag_var} MATCHES "/MD")
      string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
    endif()
  endforeach()

  # or add the following begin project()
  # if(NOT CMAKE_VERSION VERSION_LESS 3.15)
  #   cmake_policy(SET CMP0091 NEW)
  #   set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
  # endif()
  # example
  # set_property(TARGET ${test_name} PROPERTY
  #   MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

