function(add_dir_tests tests)
    # project subdirectory tests
    if(BUILD_TESTING_ALL OR BUILD_TESTING_${PROJECT_NAME})
        # option(BUILD_TESTING "Build test" OFF)
        include(CTest)
        if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/dependencies_dev.cmake)
            configure_file(${PROJECT_SOURCE_DIR}/cmake/dependencies_dev.cmake
                           cmake/dependencies_dev_${PROJECT_NAME}.cmake)
            include(dependencies_dev_${PROJECT_NAME})
        endif()
        add_subdirectory(tests)
    endif()
endfunction()
