# project subdirectory src and tests
if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake)
    configure_file(${PROJECT_SOURCE_DIR}/cmake/dependencies.cmake
                   cmake/dependencies_${PROJECT_NAME}.cmake)
    include(dependencies_${PROJECT_NAME})
endif()
add_subdirectory(src)
option(BUILD_TESTING "Build test" OFF)
include(CTest)
if(BUILD_TESTING AND PROJECT_IS_TOP_LEVEL)
    if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/dependencies_dev.cmake)
        configure_file(${PROJECT_SOURCE_DIR}/cmake/dependencies_dev.cmake
                       cmake/dependencies_dev_${PROJECT_NAME}.cmake)
        include(dependencies_dev_${PROJECT_NAME})
    endif()
    add_subdirectory(tests)
endif()
