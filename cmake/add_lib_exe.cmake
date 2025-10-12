function(add_lib_exe target)
    add_src_lib(${library_name} ${ARGN})

    # add executable
    add_src_exe(${CMAKE_CURRENT_LIST_DIR}, ${library_name})
endfunction()
