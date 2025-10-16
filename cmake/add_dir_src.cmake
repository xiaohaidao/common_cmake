function(add_dir_src src)
    # project subdirectory src
    if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake)
        configure_file(${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake
                       cmake/dependencies_${PROJECT_NAME}.cmake)
        # in ${PROJECT_BINARY_DIR}/cmake/
        include(dependencies_${PROJECT_NAME})
    endif()

    add_subdirectory(src)

    include(export_install_targets)
    export_install_targets(${PROJECT_NAME})

    if(EXISTS ${PROJECT_SOURCE_DIR}/include)
        install(
            DIRECTORY "${PROJECT_SOURCE_DIR}/include/"
            DESTINATION include
            COMPONENT dev)
    endif()
    include(use_cpack)

endfunction()
