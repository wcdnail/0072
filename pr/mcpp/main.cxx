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
    strcpy(arr1, "Trololo");
    delete [] arr1;
}
#endif

int main()
{
    printBuildHeader();
    //testMiscStuff();
    //curve_brackets_init();
    template_type_deduction();
    return 0;
}
