
if(CMAKE_VERSION VERSION_LESS 3.21)
    get_directory_property(hasParent PARENT_DIRECTORY)
    if(NOT hasParent)
        set(PROJECT_IS_TOP_LEVEL true)
    else()
        set(PROJECT_IS_TOP_LEVEL)
    endif()
endif()

#import tool
include(GNUInstallDirs)

function(RUN_CMD)
    set(_options)
    set(_one_arg WORKING_DIRECTORY)
    set(_multi_arg COMMAND)
    CMAKE_PARSE_ARGUMENTS(_prefix "${_options}" "${_one_arg}" "${_multi_arg}" ${ARGN})
    set(_unuse_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_cmd ${_prefix_COMMAND})
    set(_dir ${_prefix_WORKING_DIRECTORY})

    #message("run command : ${_cmd}")
    if(_dir)
        message("WORKING_DIRECTORY : ${_dir}")
        execute_process(
            COMMAND ${_cmd}
            RESULT_VARIABLE err_result
            WORKING_DIRECTORY ${_dir}
            COMMAND_ECHO STDOUT
        )
    else()
        execute_process(
            COMMAND ${_cmd}
            RESULT_VARIABLE err_result
            COMMAND_ECHO STDOUT
        )
    endif()
    if(err_result)
        message(FATAL_ERROR "execute process error ${err_result}")
    endif()

endfunction()

