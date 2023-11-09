
##
# @brief GTest
# @GIT_GTEST_REPOSITORY
# @GTEST_VERSION
# @GTEST_INSTALL_DIR
# link GTest:gtest
# link GTest:gtest_main
#
if (NOT GIT_GTEST_REPOSITORY)
    set(GIT_GTEST_REPOSITORY https://github.com/google/googletest.git)
endif()
if (NOT GTEST_VERSION)
    set(GTEST_VERSION release-1.10.0) # c++11
endif()

# For Windows: Prevent overriding the parent project's compiler/linker settings
#set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FIND_OR_BUILD(
    TARGET GTest
    GIT_URL ${GIT_GTEST_REPOSITORY}
    GIT_TAGS ${GTEST_VERSION}
    INSTALL_DIR ${GTEST_INSTALL_DIR}
    CMAKE_APPEND -Dgtest_force_shared_crt=ON
)
