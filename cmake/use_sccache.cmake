find_program(SCCACHE sccache)
if(NOT (SCCACHE AND PROJECT_IS_TOP_LEVEL))
    return()
endif()

set(CMAKE_C_COMPILER_LAUNCHER ${SCCACHE})
set(CMAKE_CXX_COMPILER_LAUNCHER ${SCCACHE})
set(SCCACHE_IGNORE_SERVER_IO_ERROR 1)
message("sccache exits in ${CMAKE_CURRENT_SOURCE_DIR}")

if(MSVC)
    if(${CMAKE_VERSION} VERSION_LESS "3.25")
        if(CMAKE_BUILD_TYPE STREQUAL "Debug")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_DEBUG
                           "${CMAKE_CXX_FLAGS_DEBUG}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_DEBUG
                           "${CMAKE_C_FLAGS_DEBUG}")
        elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_RELEASE
                           "${CMAKE_CXX_FLAGS_RELEASE}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_RELEASE
                           "${CMAKE_C_FLAGS_RELEASE}")
        elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_RELWITHDEBINFO
                           "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_RELWITHDEBINFO
                           "${CMAKE_C_FLAGS_RELWITHDEBINFO}")
        endif()
    else()
        set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT Embedded)
    endif()
endif()
