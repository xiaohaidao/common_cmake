add_test_exe(app_tests main.cpp)

target_compile_features(app_tests PRIVATE cxx_std_11)
target_link_libraries(
    app_tests PRIVATE GTest::gtest
                      # GTest::gtest_main GTest::gmock_main
)
