
#include "gtest/gtest.h"

namespace {

int add(int x, int y) { return x + y; }

TEST(FooFuncTest, FunctionTestExpectInt) {
  EXPECT_TRUE(add(1, 1) == 2);
  EXPECT_EQ(add(1, 1), 2);
  EXPECT_GE(add(1, 1), 2);
  EXPECT_LE(add(1, 1), 2);
  EXPECT_GT(add(1, 1), 1);
  EXPECT_LT(add(1, 1), 3);
  // ...
}

TEST(FooFuncTest, FunctionTestExpectStr) {
  EXPECT_STREQ("ccc", "ccc");
  // EXPECT_STREQ(std::string("ccc"), std::string("ccc")); // not working
  EXPECT_EQ(0, std::string("ccc").compare("ccc"));
  // ...
}

TEST(FooFuncTest, FunctionTestExpectFloat) {
  EXPECT_FLOAT_EQ(1.0, 1.0);
  EXPECT_DOUBLE_EQ(1.0, 1.0);
  EXPECT_NEAR(1.0, 1.2, 0.3);
  // ...
}

TEST(FooFuncTest, FunctionTestAssert) {
  ASSERT_TRUE(add(1, 1) == 2);
  ASSERT_EQ(add(1, 1), 2);
  ASSERT_GE(add(1, 1), 2);
  ASSERT_LE(add(1, 1), 2);
  ASSERT_GT(add(1, 1), 1);
  ASSERT_LT(add(1, 1), 3);
  // ...
}

} // namespace