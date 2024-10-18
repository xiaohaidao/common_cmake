include(CMakePackageConfigHelpers)

# install and export configure
set(library_name_target ${library_name}Targets)
set(install_export_dir ${PROJECT_BINARY_DIR}/install_export/${PROJECT_NAME}/)
install(TARGETS ${library_name} EXPORT ${library_name_target})

export(
    TARGETS ${library_name}
    NAMESPACE ${PROJECT_NAME}::
    FILE ${install_export_dir}/${library_name_target}.cmake)

set(cmake_files_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
install(
    EXPORT ${library_name_target}
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${cmake_files_install_dir})

set(library_name_config ${library_name}Config)
configure_package_config_file(
    ${CMAKE_CURRENT_LIST_DIR}/template/Config.cmake.in
    ${install_export_dir}/${library_name_config}.cmake
    INSTALL_DESTINATION ${cmake_files_install_dir})
write_basic_package_version_file(
    ${install_export_dir}/${library_name_config}Version.cmake
    # VERSION ${PROJECT_VERSION}
    COMPATIBILITY
        AnyNewerVersion # AnyNewerVersion|SameMajorVersion|SameMinorVersion|ExactVersion
)
install(FILES ${install_export_dir}/${library_name_config}.cmake
              ${install_export_dir}/${library_name_config}Version.cmake
        DESTINATION ${cmake_files_install_dir})
