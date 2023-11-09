
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

## following is FETCHCONTENT_ADDSUB
macro(FETCHCONTENT_ADDSUB)
    set(_options)
    set(_one_arg TARGET GIT_URL GIT_TAGS)
    set(_multi_arg)
    CMAKE_PARSE_ARGUMENTS(_prefix "${_options}" "${_one_arg}" "${_multi_arg}" ${ARGN})
    set(_unuse_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_target ${_prefix_TARGET})
    set(_git_url ${_prefix_GIT_URL})
    set(_git_tags ${_prefix_GIT_TAGS})

    include(FetchContent)
    FetchContent_Declare(
        ${_target}
        GIT_REPOSITORY ${_git_url}
        GIT_TAG ${_git_tags}
        GIT_SHALLOW ON
        GIT_PROGRESS ON
    )
    FetchContent_MakeAvailable(${_target})
endmacro()

## following is RUN_CMD
function(RUN_CMD)
    set(_options)
    set(_one_arg WORKING_DIRECTORY)
    set(_multi_arg COMMAND)
    CMAKE_PARSE_ARGUMENTS(_prefix "${_options}" "${_one_arg}" "${_multi_arg}" ${ARGN})
    set(_unuse_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_cmd ${_prefix_COMMAND})
    set(_dir ${_prefix_WORKING_DIRECTORY})

    #message("run command : ${_cmd}")
    if(${_dir})
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

## following is FIND_OR_BUILD
macro(FIND_OR_BUILD)
    set(_options)
    set(_one_arg TARGET GIT_URL GIT_TAGS INSTALL_DIR)
    set(_multi_arg CMAKE_APPEND)
    CMAKE_PARSE_ARGUMENTS(_prefix "${_options}" "${_one_arg}" "${_multi_arg}" ${ARGN})
    set(_unuse_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_target ${_prefix_TARGET})
    set(_git_url ${_prefix_GIT_URL})
    set(_git_tags ${_prefix_GIT_TAGS})
    set(_install_dir ${_prefix_INSTALL_DIR})
    set(_cmake_append ${_prefix_CMAKE_APPEND})

    if (NOT ${_install_dir})
        if(WIN32)
            set(HOME $ENV{USERPROFILE})
            string(REPLACE "\\" "/" HOME ${HOME})
        else()
            set(HOME $ENV{HOME})
        endif()
        string(TOLOWER ${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID} local_install)
        set(local_install ${HOME}/.cpp/${local_install})
        # message("local_install ${local_install}")

        set(_install_dir ${local_install})
    endif()
    message("${_target}_install_dir ${_install_dir}")

    if(NOT ${_target}_FOUND)
        if(MSVC)
            set(_build_type ${CMAKE_BUILD_TYPE})
            if (NOT ${_build_type})
                set(_build_type "Debug")
            endif()
        endif()
        set(install_dir ${_install_dir}/${_target}-${_git_tags}/${_build_type})
        set(${_target}_DIR "")
        find_package(${_target} CONFIG PATHS ${install_dir} NO_DEFAULT_PATH)
        if (${_target}_FOUND)
            message("${_target}_CONFIG path : ${${_target}_CONFIG}")
        endif()

    endif()

    # if(${CMAKE_VERSION} VERSION_LESS "3.16")
    #     set(empty_submodule "src")
    # else()
    #     cmake_policy(SET CMP0097 NEW)
    #     set(empty_submodule "")
    # endif()
    FetchContent_Declare(
        ${_target}
        GIT_REPOSITORY ${_git_url}
        GIT_TAG ${_git_tags}
        # GIT_SUBMODULES "src"
        GIT_SHALLOW ON
        GIT_PROGRESS ON
    )
    FetchContent_GetProperties(${_target})
    if(NOT (${_target}_POPULATED OR ${_target}_FOUND))
        FetchContent_Populate(${_target})
        string(TOLOWER ${_target} _target_lower)
        set(target_dir ${${_target_lower}_BINARY_DIR}/build/)
        set(src_dir ${${_target_lower}_SOURCE_DIR}/)

        # message("_cmake_append ${_cmake_append}")
        if(MSVC)
            RUN_CMD(
                COMMAND ${CMAKE_COMMAND} -B ${target_dir} .
                    -DCMAKE_BUILD_TYPE=${_build_type}
                    -DCMAKE_INSTALL_PREFIX=${install_dir} ${_cmake_append}
                WORKING_DIRECTORY ${src_dir}
            )
            RUN_CMD(
                COMMAND ${CMAKE_COMMAND} --build ${target_dir} -j
                    --config ${_build_type} --target install
                WORKING_DIRECTORY ${src_dir}
            )
        else()
            RUN_CMD(
                COMMAND ${CMAKE_COMMAND} -B ${target_dir} .
                    -DCMAKE_BUILD_TYPE=Release
                    -DCMAKE_INSTALL_PREFIX=${install_dir} ${_cmake_append}
                WORKING_DIRECTORY ${src_dir}
            )
            RUN_CMD(
                COMMAND ${CMAKE_COMMAND} --build ${target_dir} -j
                WORKING_DIRECTORY ${src_dir}
            )
            RUN_CMD(
                COMMAND ${CMAKE_COMMAND} --install ${target_dir} --prefix ${install_dir}
                # COMMAND ${CMAKE_COMMAND} --build ${target_dir} -j --target install
                WORKING_DIRECTORY ${src_dir}
            )
        endif()

        find_package(${_target} CONFIG REQUIRED PATHS ${install_dir} NO_DEFAULT_PATH)
        message("${_target}_CONFIG build path : ${${_target}_CONFIG}")
    endif()

endmacro()
