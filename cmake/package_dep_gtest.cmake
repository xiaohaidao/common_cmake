#
# @brief GTest link GTest:gtest link GTest:gtest_main
#
# For Windows: Prevent overriding the parent project's compiler/linker settings
# set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

include(package_module_export)

package_module_export(
    TARGET
    GTest
    GIT_URL
    https://github.com/google/googletest.git
    GIT_TAGS
    release-1.10.0 # c++11
    CMAKE_ARGS
    -Dgtest_force_shared_crt=OFF
    # -DCMP0091=NEW
    # -DCMAKE_MSVC_RUNTIME_LIBRARY="MultiThreaded$<$<CONFIG:Debug>:Debug>"
)
