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
else()
    set(option
        -fsanitize=address
        # -fsanitize=pointer-subtract -fsanitize=pointer-compare
        -fsanitize=leak -fsanitize=undefined)
    # -fsanitize=thread
    add_compile_options("$<$<BOOL:${ENABLE_MEMORY_CHECKER}>:${option}>")
    add_link_options("$<$<BOOL:${ENABLE_MEMORY_CHECKER}>:${option}>")
endif()
