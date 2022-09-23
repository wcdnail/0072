#include "stdafx.h"
#include "dumps.hxx"
#include <iostream>
#include <iomanip>
#include <initializer_list>
#include <string>
#include <numeric>

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
        std::cout << FUNC_DNAME << " >> for (auto&& it: il) :\n";
        for (auto&& it: il) {
            std::cout << DMP_DECLTYPE_NAME(it) << " : " << it << "\n";
        }
    }
};

#define DECL_CURVE_INIT(type, var, ...)  \
    type var { __VA_ARGS__ }; \
    do { \
        std::cout << std::setw(DMP_LW + 16) << std::setfill(' ') << std::right << DMP_DECLTYPE_NAME(var) << ": " #type " " #var " {" #__VA_ARGS__ << "}; " << "\n"; \
    } while (0)

#define DECL_CURVE_INIT_EQ(type, var, ...)  \
    type var = { __VA_ARGS__ }; \
    do { \
        std::cout << std::setw(DMP_LW + 16) << std::setfill(' ') << std::right << DMP_DECLTYPE_NAME(var) << ": " #type " " #var " = {" #__VA_ARGS__ << "}; " << "\n"; \
    } while (0)

void curve_brackets_init()
{
    using namespace std::string_literals;

    A a0{};
    A a1{10};
    A a2{10.0};
    A a21 = {11.0};
    A a3{5, 10.0};
    A a31 = {6, 11.0};
    A a4(7, 12);

    B b0{};
    B b1{10};
    B b2{10.0};
    B b3{5, 10};
    B b31 = {6, 11};
    B b4(5, 10);
    B b5{"раз"s, "два"s, "три"s};
    B b6{5u, 10.0};
  //B b7{10.0, 5u};                             // clang: ошибка: type 'double' cannot be narrowed to 'int' in initializer list [-Wc++11-narrowing]
                                                //   gcc: ошибка: narrowing conversion of ‘1.0e+1’ from ‘double’ to ‘int’ [-Wnarrowing]
                                                //  msvc: error C2398: Element '1': conversion from 'double' to 'int' requires a narrowing conversion

    DECL_CURVE_INIT(auto, c1, 10);
    DECL_CURVE_INIT_EQ(auto, c2, 32);
  //DECL_CURVE_INIT_EQ(auto, ce1, 10.0, 20u);   // clang: ошибка: deduced conflicting types ('double' vs 'unsigned int') for initializer list element type
                                                //   gcc: ошибка: unable to deduce ‘std::initializer_list<auto>’ from ‘{1.0e+1, 20}’
                                                //  msvc: error C3535: cannot deduce type for 'auto' from 'initializer list'
    DECL_CURVE_INIT_EQ(auto, c3, 10.0, 2.0, 3., 4.);
    DECL_CURVE_INIT_EQ(auto, c4, 1.f, 2.f, 3.f);
    DECL_CURVE_INIT(auto, c5, 562.0f);

    DECL_CURVE_INIT(auto, p1, 0);
    DECL_CURVE_INIT(auto, p2, NULL);            // gcc: предупреждение: converting to non-pointer type ‘long int’ from NULL [-Wconversion-null]
    DECL_CURVE_INIT(auto, p3, nullptr);

    DECL_CURVE_INIT_EQ(auto, pe1, 0);
    DECL_CURVE_INIT_EQ(auto, pe2, NULL);
    DECL_CURVE_INIT_EQ(auto, pe3, nullptr);

    using my_nullptr_t = std::nullptr_t;
}
