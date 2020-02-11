#include "dumps.hxx"
#include <boost/config.hpp>
#include <boost/version.hpp>
#include <boost/type_index.hpp>
#include <type_traits>
#include <limits>

void template_type_deduction();

struct Base {
    void f(int) { std::cout << "i"; }
};

struct Derived : Base {
    void f(double) { std::cout << "d"; }
};

int main()
{
    using boost::typeindex::type_id_with_cvr;

    DMP_SEP();
    std::cout << "Build host : " << BOOST_PLATFORM << "\n"
              << "Compiler   : " << BOOST_COMPILER << "\n"
              << "Library    : " << BOOST_STDLIB << "\n"
              << "Boost v.   : " << BOOST_VERSION << "\n"
              ;
    DMP_SEP();
    Derived d;
    int i = 0;
    d.f(i);
    //template_type_deduction();
    return 0;
}
