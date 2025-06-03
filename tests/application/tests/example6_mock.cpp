
#include "gmock/gmock.h"
#include "gtest/gtest.h"

namespace {

struct MockTurtle {
  MOCK_METHOD(void, F, (int distance));
  MOCK_METHOD(int, X, ());
};

TEST(PainterTest, CanDrawSomething) {
  using ::testing::AtLeast;
  using ::testing::Return;

  MockTurtle turtle;
  int n = 100;
  EXPECT_CALL(turtle, X())
      // .Times(AtLeast(2))
      .WillOnce(Return(n))
      .WillOnce(Return(n + 1))
      .WillRepeatedly(Return(n + 2));
  EXPECT_EQ(turtle.X(), 100);
  EXPECT_EQ(turtle.X(), 101);
  EXPECT_EQ(turtle.X(), 102);
  EXPECT_EQ(turtle.X(), 102);
  EXPECT_CALL(turtle, X()).WillOnce(Return(n + 3)).WillOnce(Return(n + 4));
  EXPECT_EQ(turtle.X(), 103);
  EXPECT_EQ(turtle.X(), 104);
  // EXPECT_EQ(turtle.X(), 105); // Failure

  using ::testing::_;
  using ::testing::InSequence;
  // InSequence seq;
  EXPECT_CALL(turtle, F(_));
  EXPECT_CALL(turtle, F(1));
  EXPECT_CALL(turtle, F(2));
  turtle.F(2);
  turtle.F(1);
  turtle.F(3);
}

} // namespace
