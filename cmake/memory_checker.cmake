if(NOT PROJECT_IS_TOP_LEVEL)
    return()
endif()
if(MSVC)
    set(VLD_DIR "C:/Program Files (x86)/Visual Leak Detector")
    if(EXISTS "${VLD_DIR}/include/vld.h")
        target_compile_definitions(${test_name} PRIVATE HAS_VLD_H)
    endif()
    target_include_directories(${test_name} PRIVATE "${VLD_DIR}/include")
    target_link_directories(
        ${test_name}
        PRIVATE
        if
        (CMAKE_SIZEOF_VOID_P EQUAL 8)
        "${VLD_DIR}/lib/Win64"
        elseif
        (CMAKE_SIZEOF_VOID_P EQUAL 4)
        "${VLD_DIR}/lib/Win32"
        endif
        ())
endif()

add_custom_target(
    memory-check
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=ON
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "enable memory check")

add_custom_target(
    no-memory-check
    COMMAND ${CMAKE_COMMAND} -B ${CMAKE_BINARY_DIR} -DENABLE_MEMORY_CHECKER=OFF
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "disable memory check")

# gcc  -analysis -pg -fsanitize -cov
