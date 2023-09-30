
if(CMAKE_VERSION VERSION_LESS 3.21)
    get_directory_property(hasParent PARENT_DIRECTORY)
    if(NOT hasParent)
        set(PROJECT_IS_TOP_LEVEL true)
    else()
        set(PROJECT_IS_TOP_LEVEL)
    endif()
endif()

#import tool
include(GNUInstallDirs)
