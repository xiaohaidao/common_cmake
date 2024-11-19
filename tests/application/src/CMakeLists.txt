include(use_string_version)

set(library_name ${PROJECT_NAME}lib)
add_src_lib(${library_name}
    libs.cpp
)

add_src_exe(${CMAKE_CURRENT_LIST_DIR} ${library_name})
