include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# install and export configure
if(DEFINED install_export_target)

elseif(DEFINED library_name)
    set(install_export_target ${library_name})
else()
    message(FATAL_ERROR "not found target in install_export")
endif()
set(library_name_target ${install_export_target}Targets)
set(install_export_dir ${PROJECT_BINARY_DIR}/install_export/${PROJECT_NAME}/)
install(TARGETS ${install_export_target} EXPORT ${library_name_target})

export(
    TARGETS ${install_export_target}
    NAMESPACE ${PROJECT_NAME}::
    FILE ${install_export_dir}/${library_name_target}.cmake)

set(cmake_files_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
install(
    EXPORT ${library_name_target}
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${cmake_files_install_dir})

set(library_name_config ${install_export_target}Config)
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
