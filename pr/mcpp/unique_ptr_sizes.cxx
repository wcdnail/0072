#include "stdafx.h"
#include "dumps.hxx"
#include <cstdint>
#include <memory>
#include <iostream>
#include <iomanip>
#include <string>
#include <functional>

struct Obj
{
    int           id{ 0 };
    std::string str1{ "str1" };
    std::string str2{ "str2" };

    Obj(int n = -1) : id(n) { std::cout << "C" << id << "\n"; }
    Obj(Obj&&) { std::cout << "RR" << id << "\n"; }
    Obj(const Obj&) { std::cout << "CR" << id << "\n"; }
    Obj& operator = (Obj&&) { std::cout << "ORR" << id << "\n"; return *this;  }
    Obj& operator = (const Obj&) { std::cout << "OR" << id << "\n"; return *this; }
    ~Obj() { std::cout << "D" << id << "\n"; }
};

#define DMP_EXPR1(expr)                                                                                 \
    do {                                                                                                \
        std::cout << std::setfill(' ') << std::setw(60) << std::right << #expr " : " << expr << "\n";   \
    } while (0)

static void objectDeleter(Obj *obj)
{
    delete obj;
}

void unique_ptr_size_test()
{
    uint64_t lamdaDelCount = 0;
    auto lamdaDel = [&lamdaDelCount](Obj *obj) {
        delete obj;
        ++lamdaDelCount;
    };
    using LamdaDel = decltype(lamdaDel);

    struct ObjDel
    {
        uint64_t count{ 0 };
        char      sign{ 'a' };

        void operator() (Obj *obj) noexcept
        {
            delete obj;
            ++count;
        }
    };

    std::cout << "LambdaDel : " << DMP_DECLTYPE_NAME(lamdaDel) << "\n";

    DMP_EXPR1(sizeof(Obj));
    DMP_EXPR1(sizeof(Obj*));
    DMP_EXPR1(sizeof(LamdaDel));
    DMP_EXPR1(sizeof(lamdaDel));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, ObjDel>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, void(*)(Obj*)>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, std::function<void(Obj*)>>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, LamdaDel>));

    ObjDel customDeleter;
    std::unique_ptr<Obj, ObjDel> customDelObj(new Obj(1), customDeleter);
    std::unique_ptr<Obj, void(*)(Obj*)> funcDelObj(new Obj(2), objectDeleter);
    std::unique_ptr<Obj, std::function<void(Obj*)>> funcDelObj2(new Obj(3), objectDeleter);
    std::unique_ptr<Obj, LamdaDel> lambdaDelObj(new Obj(4), lamdaDel);
    std::cout << std::endl;
}
