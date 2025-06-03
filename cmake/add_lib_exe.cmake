function(add_lib_exe target)
    set(library_name ${target})
    add_library(${library_name} ${ARGN})
    add_library(${PROJECT_NAME}::${library_name} ALIAS ${library_name})

    target_link_libraries(${library_name} PUBLIC)

    target_include_directories(
        ${library_name}
        PRIVATE ${PROJECT_SOURCE_DIR}/src/
        PUBLIC $<INSTALL_INTERFACE:include/>
               $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include/>)

    # set_target_properties(${library_name} PROPERTIES PUBLIC_HEADER
    # $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include/> )

    target_compile_features(${library_name} PUBLIC # cxx_std_11
    )

    # install and export configure
    include(use_install_export)

    # add executable
    if(EXISTS /main.cpp)
        add_executable(${PROJECT_NAME} main.cpp)

        target_link_libraries(${PROJECT_NAME} PRIVATE ${library_name})
        set(install_export_target ${PROJECT_NAME})
        include(use_install_export)
    endif()
    if(EXISTS bin)
        # file(GLOB_RECURSE bin_files "bin/*.cpp")
        file(GLOB bin_files "bin/*.cpp")
        foreach(f ${bin_files})
            get_filename_component(name ${f} NAME_WE)
            add_executable(${name} ${f})

            target_link_libraries(${name} PRIVATE ${library_name})
            set(install_export_target ${name})
            include(use_install_export)
        endforeach()
    endif()

endfunction()
