#include "dumps.hxx"
#include <iostream>
#include <iomanip>
#include <initializer_list>
#include <string>

struct A
{
    A() { std::cout << FUNC_DNAME << "\n"; }
    A(int x) { std::cout << FUNC_DNAME << " (" << x << ")" << "\n"; }
    A(double y) { std::cout << FUNC_DNAME << " (" << y << ")" << "\n"; }
    A(int x, double y) { std::cout << FUNC_DNAME << " (" << x << ", " << y  << ")" << "\n"; }
};

struct B
{
    B() { std::cout << FUNC_DNAME << "\n"; }
    B(int x) { std::cout << FUNC_DNAME << " (" << x << ")" << "\n"; }
    B(double y) { std::cout << FUNC_DNAME << " (" << y << ")" << "\n"; }
    B(int x, double y) { std::cout << FUNC_DNAME << " (" << x << ", " << y  << ")" << "\n"; }

    template <typename T>
    B(std::initializer_list<T> il)
    {
        std::cout << FUNC_DNAME << "\n";
        for (auto&& it: il) {
            std::cout << DMP_DECLTYPE_NAME(it) << " : " << it << "\n";
        }
    }
};

void curve_brackets_init()
{
    using namespace std::string_literals;

    A a0{};
    A a1{10};
    A a2{10.0};
    A a3{5, 10.0};
    A a4(7, 12);

    B b0{};
    B b1{10};
    B b2{10.0};
    B b3{5, 10};
    B b4(5, 10);
    B b5{"раз"s, "два"s, "три"s};
}
