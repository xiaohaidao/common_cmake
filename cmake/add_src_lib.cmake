function(add_src_lib target)
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
endfunction()
