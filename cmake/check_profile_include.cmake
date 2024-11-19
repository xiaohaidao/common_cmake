if(NOT PROJECT_IS_TOP_LEVEL)
    return()
endif()

add_compile_options("$<$<BOOL:${ENABLE_PROFILE_CHECKER}>:-pg>")
add_link_options("$<$<BOOL:${ENABLE_PROFILE_CHECKER}>:-pg>")
