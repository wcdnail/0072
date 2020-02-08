#include <iomanip>
#include <iostream>
#include <boost/config.hpp>
#include <boost/version.hpp>

void template_type_deduction();

int main()
{
    std::cout << "=============================================================\n"
              << "Build host : " << BOOST_PLATFORM << "\n"
              << "Compiler   : " << BOOST_COMPILER << "\n"
              << "Library    : " << BOOST_STDLIB << "\n"
              << "Boost v.   : " << BOOST_VERSION << "\n"
              << "=============================================================\n"
              ;
    //template_type_deduction();
    return 0;
}
