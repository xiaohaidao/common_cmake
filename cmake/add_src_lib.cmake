function(add_src_lib target)
    set(library_name ${target})
    add_library(${library_name} ${ARGN})
    add_library(${PROJECT_NAME}::${library_name} ALIAS ${library_name})

    target_link_libraries(${library_name} PUBLIC)

    target_include_directories(
        ${library_name}
        PRIVATE ${PROJECT_SOURCE_DIR}/src/
        PRIVATE ${CMAKE_CURRENT_LIST_DIR}
        PUBLIC $<INSTALL_INTERFACE:include/>
               $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include/>)

    # set_target_properties(${library_name} PROPERTIES PUBLIC_HEADER
    # $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include/> )

    target_compile_features(${library_name} PUBLIC # cxx_std_11
    )

    # install and export configure
    get_target_property(target_type ${library_name} TYPE)
    message(".... library_name : ${library_name}, ${target_type}")
    if(target_type STREQUAL "SHARED_LIBRARY")
        install(
            TARGETS ${library_name}
            EXPORT ${PROJECT_NAME}
            COMPONENT runtime)
    else()
        install(
            TARGETS ${library_name}
            EXPORT ${PROJECT_NAME}
            COMPONENT dev)
    endif()
endfunction()
