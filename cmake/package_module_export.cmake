include(package_module_utils)

function(package_module_export)
    set(_options)
    set(_one_arg TARGET GIT_URL GIT_TAGS INSTALL_DIR)
    set(_multi_arg CMAKE_ARGS)
    cmake_parse_arguments(_argv "${_options}" "${_one_arg}" "${_multi_arg}"
                          ${ARGN})
    set(target ${_argv_TARGET})
    set(version ${_argv_GIT_TAGS})
    set(git_url ${_argv_GIT_URL})
    set(install_dir ${_argv_INSTALL_DIR})

    package_module_find(
        found
        TARGET
        ${target}
        GIT_TAGS
        ${version}
        INSTALL_DIR
        ${install_dir})
    if(NOT found)
        get_local_package_install_dir(
            local_install_dir
            TARGET
            ${target}
            VERSION
            ${version}
            INSTALL_DIR
            ${install_dir})
        package_module_build(
            TARGET
            ${target}
            GIT_TAGS
            ${version}
            GIT_URL
            ${git_url}
            INSTALL_DIR
            ${local_install_dir}
            CMAKE_ARGS
            ${_argv_CMAKE_ARGS})
        package_module_find(
            found
            TARGET
            ${target}
            GIT_TAGS
            ${version}
            INSTALL_DIR
            ${install_dir})
        if(NOT found)
            message(FATAL_ERROR "not found target ${target}-${version}")
            # else() message("${target}-${version} found")
        endif()
    endif()
endfunction()
