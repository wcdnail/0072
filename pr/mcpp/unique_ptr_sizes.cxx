#include "stdafx.h"
#include "dumps.hxx"
#include <memory>
#include <iostream>
#include <iomanip>
#include <string>
#include <cstdint>

struct Obj
{
    int           id{ 0 };
    std::string str1{ "str1" };
    std::string str2{ "str2" };

    Obj(int n = -1) : id(n) { std::cout << "C" << id << " "; }
    Obj(Obj&&) { std::cout << "RR" << id << " "; }
    Obj(const Obj&) { std::cout << "CR" << id << " "; }
    Obj& operator = (Obj&&) { std::cout << "ORR" << id << " "; return *this;  }
    Obj& operator = (const Obj&) { std::cout << "OR" << id << " "; return *this; }
    ~Obj() { std::cout << "D" << id << "\n"; }
};

struct ObjDel
{
    uint64_t count{ 0 };

    void operator() (Obj *obj) noexcept
    {
        delete obj;
        ++count;
    }
};

#define DMP_EXPR1(expr)                                                                                 \
    do {                                                                                                \
        std::cout << std::setfill(' ') << std::setw(60) << std::right << #expr " : " << expr << "\n";   \
    } while (0)

void unique_ptr_size_test()
{
    uint64_t lamdaDelCount = 0;
    auto lamdaDel = [&lamdaDelCount](Obj *obj) {
        delete obj;
        ++lamdaDelCount;
    };
    using LamdaDel = decltype(lamdaDel);

    DMP_EXPR1(sizeof(Obj));
    DMP_EXPR1(sizeof(Obj*));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, ObjDel>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, LamdaDel>));

    ObjDel customDeleter;
    {
        std::unique_ptr<Obj, ObjDel> customDelObj(new Obj(1), customDeleter);
    }
    {
        std::unique_ptr<Obj, LamdaDel> lambdaDelObj(new Obj(2), lamdaDel);
    }
    std::cout << std::endl;
}
