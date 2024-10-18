function(package_module_find found)
    set(_options)
    set(_one_arg TARGET GIT_TAGS INSTALL_DIR)
    set(_multi_arg)
    cmake_parse_arguments(_argv "${_options}" "${_one_arg}" "${_multi_arg}"
                          ${ARGN})
    set(target ${_argv_TARGET})

    get_local_package_install_dir(
        package_install_dir
        TARGET
        ${_argv_TARGET}
        VERSION
        ${_argv_GIT_TAGS}
        INSTALL_DIR
        ${_argv_INSTALL_DIR})
    set(CMAKE_PREFIX_PATH ${package_install_dir})
    find_package(${target} CONFIG) # PATHS ${package_install_dir})

    if(${${target}_FOUND})
        message("found ${target} in ${${target}_CONFIG}")
    endif()
    set(${found}
        ${${target}_FOUND}
        PARENT_SCOPE)
endfunction()

function(get_local_home_dir home_dir)
    if(WIN32)
        set(HOME_PATH $ENV{USERPROFILE})
        string(REPLACE "\\" "/" HOME_PATH ${HOME_PATH})
    else()
        set(HOME_PATH $ENV{HOME})
    endif()
    set(${home_dir}
        ${HOME_PATH}/
        PARENT_SCOPE)
endfunction()

function(get_local_package_install_dir local_install_dir)
    cmake_parse_arguments(_argv "" "TARGET;VERSION;INSTALL_DIR" "" ${ARGN})
    set(target ${_argv_TARGET})
    set(version ${_argv_VERSION})

    set(prefix_install_dir ${_argv_INSTALL_DIR})
    if(NOT DEFINED ${prefix_install_dir})
        get_local_home_dir(prefix_install_dir)
        string(APPEND prefix_install_dir ".cpp/")
    endif()

    string(
        TOLOWER
            ${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_SYSTEM_NAME}-${CMAKE_C_COMPILER_ID}
            arch_dir)
    string(APPEND prefix_install_dir "${arch_dir}/")
    string(APPEND prefix_install_dir "${target}-${version}/")

    if(MSVC)
        set(build_type ${CMAKE_BUILD_TYPE})
        if("${build_type}" STREQUAL "")
            set(build_type "Debug")
        endif()
    endif()
    string(APPEND prefix_install_dir "${build_type}/")

    set(${local_install_dir}
        ${prefix_install_dir}
        PARENT_SCOPE)
endfunction()

function(process_cmd)
    cmake_parse_arguments(_argv "NO_EXIT" "WORKING_DIRECTORY" "COMMAND" ${ARGN})
    set(_unuse_list ${_argv_UNPARSED_ARGUMENTS})
    set(_cmd ${_argv_COMMAND})
    set(_dir ${_argv_WORKING_DIRECTORY})

    # message("run command : ${_cmd}") if (DEFINED _dir)
    # message("WORKING_DIRECTORY : ${_dir}") endif()
    execute_process(
        COMMAND ${_cmd}
        RESULT_VARIABLE err_result
        WORKING_DIRECTORY ${_dir} COMMAND_ECHO STDOUT)
    if(err_result)
        if(NOT ${_argv_NO_EXIT})
            message(FATAL_ERROR "execute process error ${err_result}")
        else()
            message(WARNING "execute process error ${err_result}")
        endif()
    endif()

endfunction()

function(package_module_build)
    set(_options)
    set(_one_arg TARGET GIT_URL GIT_TAGS INSTALL_DIR)
    set(_multi_arg CMAKE_ARGS)
    cmake_parse_arguments(_argv "${_options}" "${_one_arg}" "${_multi_arg}"
                          ${ARGN})
    set(target ${_argv_TARGET})
    set(git_url ${_argv_GIT_URL})
    set(git_tags ${_argv_GIT_TAGS})
    set(install_dir ${_argv_INSTALL_DIR})
    set(cmake_args ${_argv_CMAKE_ARGS})

    FetchContent_Declare(
        ${target}
        GIT_REPOSITORY ${git_url}
        GIT_TAG ${git_tags}
        # GIT_SUBMODULES "src"
        GIT_SHALLOW ON
        GIT_PROGRESS ON)
    FetchContent_GetProperties(${target})
    if(NOT ${target}_POPULATED)
        set(build_type RELEASE)
        if(MSVC)
            set(build_type ${CMAKE_BUILD_TYPE})
            if("${build_type}" STREQUAL "")
                set(build_type "Debug")
            endif()
        endif()
        FetchContent_Populate(${target})
        string(TOLOWER ${target} target_lower)
        set(target_dir ${${target_lower}_BINARY_DIR}/build/)
        set(src_dir ${${target_lower}_SOURCE_DIR}/)

        # message("cmake_args ${cmake_args}")
        process_cmd(
            COMMAND
            ${CMAKE_COMMAND}
            -B
            ${target_dir}
            .
            -DCMAKE_BUILD_TYPE=${build_type}
            -DCMAKE_INSTALL_PREFIX=${install_dir}
            ${cmake_args}
            WORKING_DIRECTORY
            ${src_dir})
        if(MSVC)
            process_cmd(
                COMMAND
                ${CMAKE_COMMAND}
                --build
                ${target_dir}
                -j
                --config
                ${build_type}
                --target
                install
                WORKING_DIRECTORY
                ${src_dir})
        else()
            process_cmd(
                COMMAND
                ${CMAKE_COMMAND}
                --build
                ${target_dir}
                -j
                WORKING_DIRECTORY
                ${src_dir})
            process_cmd(
                COMMAND
                ${CMAKE_COMMAND}
                --install
                ${target_dir}
                --prefix
                ${install_dir}
                # COMMAND ${CMAKE_COMMAND} --build ${target_dir} -j --target
                # install
                WORKING_DIRECTORY
                ${src_dir})
        endif()
        # find_package(${target} CONFIG REQUIRED PATHS ${install_dir}
        # NO_DEFAULT_PATH) message("${target}_CONFIG build path :
        # ${${target}_CONFIG}")
    endif()
endfunction()
