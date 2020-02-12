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
    auto lambdaDel = [](Obj *obj) {
        delete obj;
    };
    using LambdaDel = decltype(lambdaDel);

    uint64_t lambdaDelCount = 0;
    auto lambdaDelComp = [&lambdaDelCount](Obj *obj) {
        delete obj;
        ++lambdaDelCount;
    };
    using LambdaDelComp = decltype(lambdaDelComp);

    struct ObjDel
    {
        void operator() (Obj *obj) noexcept
        {
            delete obj;
        }
    };

    struct ObjDelComp
    {
        uint64_t count{ 0 };
        void operator() (Obj *obj) noexcept
        {
            delete obj;
            ++count;
        }
    };

    std::cout << "LambdaDel : " << DMP_DECLTYPE_NAME(lambdaDel) << "\n";

    DMP_EXPR1(sizeof(Obj));
    DMP_EXPR1(sizeof(Obj*));
    DMP_EXPR1(sizeof(LambdaDel));
    DMP_EXPR1(sizeof(lambdaDel));
    DMP_EXPR1(sizeof(ObjDel));
    DMP_EXPR1(sizeof(LambdaDelComp));
    DMP_EXPR1(sizeof(lambdaDelComp));
    DMP_EXPR1(sizeof(ObjDelComp));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, ObjDel>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, LambdaDel>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, ObjDelComp>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, LambdaDelComp>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, void(*)(Obj*)>));
    DMP_EXPR1(sizeof(std::unique_ptr<Obj, std::function<void(Obj*)>>));

    ObjDel customDeleter;
    std::unique_ptr<Obj, ObjDel> customDelObj(new Obj(1), customDeleter);
    std::unique_ptr<Obj, LambdaDel> lambdaDelObj(new Obj(2), lambdaDel);
    std::unique_ptr<Obj, void(*)(Obj*)> funcDelObj(new Obj(3), objectDeleter);
    std::unique_ptr<Obj, std::function<void(Obj*)>> funcDelObj2(new Obj(4), objectDeleter);

    std::cout << std::endl;
}
