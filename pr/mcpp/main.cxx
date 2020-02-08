#include "dumps.hxx"
#include <boost/config.hpp>
#include <boost/version.hpp>

void template_type_deduction();

int main()
{
    DMP_SEP();
    std::cout << "Build host : " << BOOST_PLATFORM << "\n"
              << "Compiler   : " << BOOST_COMPILER << "\n"
              << "Library    : " << BOOST_STDLIB << "\n"
              << "Boost v.   : " << BOOST_VERSION << "\n"
              ;
    DMP_SEP();
    template_type_deduction();
    return 0;
}
