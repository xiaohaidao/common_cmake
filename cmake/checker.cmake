include(${CMAKE_CURRENT_LIST_DIR}/check_clang_tidy.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/check_memory.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/check_profile.cmake)

add_custom_target(checker)
add_dependencies(checker clang-tidy)
add_dependencies(checker check-memory)
add_dependencies(checker check-profile)

add_custom_target(unchecker)
add_dependencies(unchecker clang-tidy-cancel)
add_dependencies(unchecker check-memory-cancel)
add_dependencies(unchecker check-profile-cancel)
