
find_program(SCCACHE sccache)

if(SCCACHE AND PROJECT_IS_TOP_LEVEL)
    set(CMAKE_C_COMPILER_LAUNCHER ${SCCACHE})
    set(CMAKE_CXX_COMPILER_LAUNCHER ${SCCACHE})
    set(SCCACHE_IGNORE_SERVER_IO_ERROR 1)

    if(MSVC)
        if(${CMAKE_VERSION} VERSION_LESS "3.27")
            foreach(flag_var
              CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
              CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
              CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
              CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)

              if(${flag_var} MATCHES "/Zi")
                string(REGEX REPLACE "/Zi" "/Z7" ${flag_var} "${${flag_var}}")
              endif()
            endforeach()
        else()
            set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT Embedded)
        endif()
    endif()
endif()