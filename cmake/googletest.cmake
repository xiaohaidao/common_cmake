
if (GIT_GOOGLETEST_REPOSITORY)
    set(GIT_GOOGLETEST_REPOSITORY https://github.com/google/googletest.git)
    set(GOOGLETEST_VERSION release-1.10.0)
endif()

include(FetchContent)
FetchContent_Declare(
    googletest
    GIT_REPOSITORY ${GIT_GOOGLETEST_REPOSITORY}
    GIT_TAG ${GOOGLETEST_VERSION}
    GIT_SHALLOW ON
    GIT_PROGRESS ON
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)
