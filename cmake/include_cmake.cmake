set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(CMAKE_VERSION VERSION_LESS 3.21)
    get_directory_property(hasParent PARENT_DIRECTORY)
    if(NOT hasParent)
        set(PROJECT_IS_TOP_LEVEL true)
    else()
        set(PROJECT_IS_TOP_LEVEL)
    endif()
endif()
if(${PROJECT_NAME} STREQUAL "workspace_project"
   OR EXISTS ${PROJECT_SOURCE_DIR}/conanws.py
   OR EXISTS ${PROJECT_SOURCE_DIR}/conanws.xml)
    message("-- ${PROJECT_NAME} is workspace")
    set(PROJECT_IS_WORKSPACE true)
else()
    set(PROJECT_IS_WORKSPACE)
    message("-- ${PROJECT_NAME} is project ${PROJECT_IS_WORKSPACE}")
endif()

include(docs)
include(format)
include(checker)

# include(use_static_runtime) include(use_sccache) include(use_string_version)
