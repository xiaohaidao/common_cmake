
#include "gmock/gmock.h"
#include "gtest/gtest.h"

namespace {

void Foo() {
  int *pInt = 0;
  *pInt = 42;
}

TEST(FooDeathTest, Demo) {
  EXPECT_DEATH(Foo(), "");
  EXPECT_EXIT(_exit(1), testing::ExitedWithCode(1), "");
}

} // namespace
