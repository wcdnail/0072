#include "stdafx.h"
#include "dumps.hxx"
//#include "clib_wrappers.hxx"
#include <cstdint>
#include <memory>
#include <iostream>
#include <iomanip>
#include <string>
#include <functional>

struct Obj2
{
    int          id{ 0 };
    char buffer[16]{ 0 };

    Obj2(int n = -1)
        : id(n)
    {
        strncpy_s(buffer, "data", sizeof(buffer));
        //std::cout << "C" << id << "\n"; 
    }

    Obj2(Obj2 &&) 
    {
        strncpy_s(buffer, "moved data", sizeof(buffer));
        //std::cout << "RR" << id << "\n";
    }

    Obj2(const Obj2&) 
    {
        strncpy_s(buffer, "copied data", sizeof(buffer));
        //std::cout << "CR" << id << "\n"; 
    }

    Obj2& operator = (Obj2&&) 
    {
        strncpy_s(buffer, "moved op data", sizeof(buffer));
        //std::cout << "ORR" << id << "\n";
        return *this;
    }

    Obj2& operator = (const Obj2&) 
    {
        strncpy_s(buffer, "copied op data", sizeof(buffer));
        //std::cout << "OR" << id << "\n";
        return *this;
    }

    virtual ~Obj2()
    { 
        //std::cout << "D" << id << "\n";
        memset(buffer, 0, sizeof(buffer));
        id = -1;
    }
};

void smart_ptr_dump()
{
    DMP_SEP();

    DMP_EXPR1(60, sizeof(Obj2));
    DMP_EXPR1(60, sizeof(Obj2*));
    DMP_EXPR1(60, sizeof(std::shared_ptr<Obj2>));

    auto obj1 = std::make_shared<Obj2>(1);

    auto all1 = std::allocator<Obj2>();
    auto obj2 = std::allocate_shared<Obj2>(all1, 2);
}
