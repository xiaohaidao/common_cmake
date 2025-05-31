#
# param: file regex param: work directory param: filter dir param: filter file
#
function(file_glob FILES)
    cmake_parse_arguments(_argv "" "WORKING_DIRECTORY" "FILTER_DIR;FILTER_FILE"
                          ${ARGN})
    set(work_dir ${_argv_WORKING_DIRECTORY})
    set(filter_dir ${_argv_FILTER_DIR})
    set(filter_file ${_argv_FILTER_FILE})
    set(regex_file ${_argv_UNPARSED_ARGUMENTS})
    if(NOT DEFINED work_dir)
        set(work_dir ${CMAKE_SOURCE_DIR})
    endif()
    if(NOT DEFINED filter_dir)
        set(filter_dir \\..+)
    endif()
    if(NOT DEFINED filter_file)
        set(filter_file CMakeCache.txt)
    endif()

    set(all_files)
    foreach(tmp_regex_file ${regex_file})
        file(
            GLOB file_lists
            LIST_DIRECTORIES false
            "${work_dir}/${tmp_regex_file}")
        list(APPEND all_files ${file_lists})
    endforeach()
    file_glob_subdir(subdir ${work_dir})
    foreach(tmp_dir ${subdir})
        set(skip_dir false)
        foreach(tmp_filter_dir ${filter_dir})
            if(${tmp_dir} MATCHES ${work_dir}/${tmp_filter_dir})
                set(skip_dir true)
                break()
            endif()
        endforeach()
        foreach(tmp_filter_file ${filter_file})
            if(EXISTS ${tmp_dir}/${tmp_filter_file})
                set(skip_dir true)
                break()
            endif()
        endforeach()
        if(${skip_dir})
            # message("skip dir ${tmp_dir}")
            continue()
        endif()
        file_glob(
            file_lists
            ${regex_file}
            WORKING_DIRECTORY
            ${tmp_dir}
            FILTER_DIR
            ${filter_dir}
            FILTER_FILE
            ${filter_filter})
        list(APPEND all_files ${file_lists})
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
