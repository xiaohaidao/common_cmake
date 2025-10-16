include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# install(TARGETS ${install_export_target} EXPORT ${library_name_target})

function(export_install_targets target_name)
    # set(target_name ${PROJECT_NAME})
    set(install_export_dir
        ${PROJECT_BINARY_DIR}/install_export/${PROJECT_NAME}/)

    set(cmake_files_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
    install(
        EXPORT ${target_name}
        NAMESPACE ${target_name}::
        DESTINATION ${cmake_files_install_dir}
        COMPONENT dev
        FILE ${target_name}Targets.cmake)

    set(target_name_config ${target_name}Config)
    configure_package_config_file(
        ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/template/Config.cmake.in
        ${install_export_dir}/${target_name_config}.cmake
        INSTALL_DESTINATION ${cmake_files_install_dir})
    write_basic_package_version_file(
        ${install_export_dir}/${target_name_config}Version.cmake
        # VERSION ${PROJECT_VERSION}
        COMPATIBILITY
            AnyNewerVersion # AnyNewerVersion|SameMajorVersion|SameMinorVersion|ExactVersion
    )
    install(
        FILES ${install_export_dir}/${target_name_config}.cmake
              ${install_export_dir}/${target_name_config}Version.cmake
        COMPONENT dev
        DESTINATION ${cmake_files_install_dir})
endfunction()
