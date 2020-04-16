#include "stdafx.h"
#include "dumps.hxx"
#include <iostream>
#include <iomanip>
#include <vector>
#include <set>
#include <map>
#include <unordered_map>
#include <unordered_set>
#include <type_traits>
#include <array>
#include <boost/config.hpp>
#include <boost/version.hpp>
#include <boost/type_index.hpp>

void template_type_deduction();
void curve_brackets_init();
void autogenerated_ctros_test();
void unique_ptr_size_test();
void smart_ptr_dump();
void uref_overloads();
void async_1_test();
void async_2_test();

static inline void printBuildHeader()
{
    DMP_SEP();
    std::cout << "Build host : " << BOOST_PLATFORM << "\n"
              << "Compiler   : " << BOOST_COMPILER << "\n"
              << "Library    : " << BOOST_STDLIB << "\n"
              << "Boost v.   : " << BOOST_VERSION << "\n"
              << "C++        : " << __cplusplus << "\n"
              ;
    DMP_SEP();
}

#if 0
static inline void testMiscStuff()
{
    auto arr1 = new char[1024];
    strcpy(arr1, "some text");
    delete [] arr1;
}
#endif

int main()
{
    printBuildHeader();
    //testMiscStuff();
    //curve_brackets_init();
    //template_type_deduction();
    //autogenerated_ctros_test();
    //unique_ptr_size_test();
    //smart_ptr_dump();
    //uref_overloads();
    //async_1_test();
    async_2_test();
    return 0;
}
