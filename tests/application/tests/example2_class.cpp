
#include "gtest/gtest.h"

namespace {

struct FooClassTest : testing::Test {
  static void SetUpTestSuite() {
    g_queue.push_back(1);
    g_queue.push_back(2);
    g_queue.push_back(3);
  }
  static void TearDownTestSuite() { g_queue.clear(); }

  void SetUp() override {
    m_queue.push_back(1);
    m_queue.push_back(2);
    m_queue.push_back(3);
  }
  void TearDown() override { m_queue.clear(); }
  std::vector<int> m_queue;

  static std::vector<int> g_queue;
};
std::vector<int> FooClassTest::g_queue;

TEST_F(FooClassTest, FooClassTempMember) {
  EXPECT_EQ(m_queue.size(), 3u);
  m_queue.push_back(4);
  EXPECT_EQ(m_queue.size(), 4u);
}

TEST_F(FooClassTest, FooClassTempMember2) {
  EXPECT_EQ(m_queue.size(), 3u);
  m_queue.push_back(4);
  EXPECT_EQ(m_queue.size(), 4u);
}

TEST_F(FooClassTest, FooClassGlobalMember1) {
  EXPECT_EQ(g_queue.size(), 3u);
  g_queue.push_back(4);
  EXPECT_EQ(g_queue.size(), 4u);
}

TEST_F(FooClassTest, FooClassGlobalMember2) {
  EXPECT_EQ(g_queue.size(), 4u);
  g_queue.push_back(5);
  EXPECT_EQ(g_queue.size(), 5u);
}

} // namespace
