
#include "gmock/gmock.h"
#include "gtest/gtest.h"

#include <list>

namespace {

template <typename T> struct FooClassTest : testing::Test {
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
  T m_queue;

  static T g_queue;
};
template <typename T> T FooClassTest<T>::g_queue;

using TypeList =
    testing::Types<std::vector<int>, std::vector<uint64_t>, std::list<int> >;
TYPED_TEST_SUITE(FooClassTest, TypeList);

TYPED_TEST(FooClassTest, FooClassTempMember) {
  EXPECT_EQ(this->m_queue.size(), 3u);
  this->m_queue.push_back(4);
  EXPECT_EQ(this->m_queue.size(), 4u);
}

TYPED_TEST(FooClassTest, FooClassTempMember2) {
  EXPECT_EQ(this->m_queue.size(), 3u);
  this->m_queue.push_back(4);
  EXPECT_EQ(this->m_queue.size(), 4u);
}

TYPED_TEST(FooClassTest, FooClassGlobalMember1) {
  EXPECT_EQ(this->g_queue.size(), 3u);
  this->g_queue.push_back(4);
  EXPECT_EQ(this->g_queue.size(), 4u);
}

TYPED_TEST(FooClassTest, FooClassGlobalMember2) {
  EXPECT_EQ(this->g_queue.size(), 4u);
  this->g_queue.push_back(5);
  EXPECT_EQ(this->g_queue.size(), 5u);
}

} // namespace
