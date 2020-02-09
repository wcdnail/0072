#include "dumps.hxx"
#include <iostream>
#include <iomanip>
#include <vector>
#include <set>
#include <map>
#include <unordered_map>
#include <unordered_set>
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
              ;
    DMP_SEP();
}

static inline void testMiscStuff()
{
    std::vector c1 = { 1, 2, 3 };
    for(auto&& el: c1) {
        std::cout << DMP_DECLTYPE_NAME(el) << " : " << el << "\n";
    }
}

int main()
{
    printBuildHeader();
    curve_brackets_init();
    //testMiscStuff();
    //template_type_deduction();
    return 0;
}
