function(file_glob FILES)
    cmake_parse_arguments(_argv "" "WORKING_DIRECTORY" "" ${ARGN})
    set(work_dir ${_argv_WORKING_DIRECTORY})
    set(other_argn ${_argv_UNPARSED_ARGUMENTS})
    if(NOT DEFINED work_dir)
        set(work_dir ${CMAKE_SOURCE_DIR})
    endif()
    file_glob_subdir(dirs ${work_dir})
    list(APPEND dirs ${work_dir})
    # message("glob begin dir:${dirs}")
    foreach(tmp_dir ${dirs})
        if(EXISTS ${tmp_dir}/CMakeCache.txt )
            # message("skip dir : ${tmp_dir}")
            continue()
        endif()
        set(all_expr)
        foreach(tmp_expr ${other_argn})
            list(APPEND all_expr ${tmp_dir}/${tmp_expr})
        endforeach()
        # message("glob begin expr:${all_expr}")
        if(${tmp_dir} STREQUAL ${work_dir})
            file(
                GLOB file_list
                LIST_DIRECTORIES false
                ${all_expr})
        else()
            file(
                GLOB_RECURSE file_list
                LIST_DIRECTORIES false
                ${all_expr})
        endif()
        list(APPEND all_files ${file_list})
    endforeach()

    # message("glob begin done:${all_files}")
    set(${FILES}
        ${all_files}
        PARENT_SCOPE)
endfunction()

function(file_glob_subdir subdirs dir)
    file(
        GLOB file_list
        LIST_DIRECTORIES true
        "${dir}/*")
    foreach(tmp_path ${file_list})
        if(IS_DIRECTORY ${tmp_path})
            list(APPEND dirs ${tmp_path})
        endif()
    endforeach()
    set(${subdirs}
        ${dirs}
        PARENT_SCOPE)
endfunction()
