
#include "gmock/gmock.h"
#include "gtest/gtest.h"

namespace {

////////////////////////////////////////////////////////////////////////////////
// int
////////////////////////////////////////////////////////////////////////////////
class FooTestParamInt : public testing::TestWithParam<int> {};

TEST_P(FooTestParamInt, FooTestParam) {
  EXPECT_GE(GetParam(), 0);
  EXPECT_LE(GetParam(), 10);
  std::cout << "int param: " << GetParam() << "\n";
}

INSTANTIATE_TEST_SUITE_P(Group, FooTestParamInt, testing::Range(0, 10));

////////////////////////////////////////////////////////////////////////////////
// str
////////////////////////////////////////////////////////////////////////////////
class FooTestParamStr : public testing::TestWithParam<const char *> {};

TEST_P(FooTestParamStr, FooTestParam) {
  std::cout << "str param: " << GetParam() << "\n";
}

INSTANTIATE_TEST_SUITE_P(Group, FooTestParamStr,
                         testing::Values("one", "two", "three"));

////////////////////////////////////////////////////////////////////////////////
// tuple
////////////////////////////////////////////////////////////////////////////////
enum class MyType { MY_FOO = 0, MY_BAR = 1 };

class FooTestParamTuple
    : public testing::TestWithParam<std::tuple<MyType, std::string> > {};

INSTANTIATE_TEST_SUITE_P(
    Group, FooTestParamTuple,
    testing::Combine(testing::Values(MyType::MY_FOO, MyType::MY_BAR),
                     testing::Values("A", "B")),
    [](const testing::TestParamInfo<FooTestParamTuple::ParamType> &info) {
      return std::string(std::get<0>(info.param) == MyType::MY_FOO ? "Foo"
                                                                   : "Bar") +
             "_" + std::get<1>(info.param);
    });

TEST_P(FooTestParamTuple, FooTestParam) {
  std::cout << "tuple param: "
            << (std::get<0>(GetParam()) == MyType::MY_FOO ? "Foo" : "Bar")
            << ":" << std::get<1>(GetParam()) << "\n";
}

} // namespace