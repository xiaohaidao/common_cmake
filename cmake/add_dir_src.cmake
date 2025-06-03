function(add_dir_src src)
    # project subdirectory src
    if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake)
        configure_file(${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake
                       cmake/dependencies_${PROJECT_NAME}.cmake)
        include(dependencies_${PROJECT_NAME})
    endif()
    add_subdirectory(src)

endfunction()
