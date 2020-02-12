#include "stdafx.h"
#include "dumps.hxx"
#include <cstdint>
#include <memory>
#include <iostream>
#include <iomanip>
#include <string>
#include <functional>

struct Obj1
{
    int           id{ 0 };
    std::string str1{ "str1" };

    Obj1(int n = -1)
        : id(n) 
    {
        //std::cout << "C" << id << "\n";
    }

    Obj1(Obj1&&) 
    {
        //std::cout << "RR" << id << "\n";
    }

    Obj1(const Obj1&) 
    {
        //std::cout << "CR" << id << "\n";
    }

    Obj1& operator = (Obj1&&) 
    {
        //std::cout << "ORR" << id << "\n"; return *this;
    }

    Obj1& operator = (const Obj1&) 
    {
        //std::cout << "OR" << id << "\n"; return *this;
    }

    virtual ~Obj1() 
    {
        //std::cout << "D" << id << "\n";
    }
};

static void objectDeleter(Obj1 *obj)
{
    delete obj;
}

void unique_ptr_size_test()
{
    auto lambdaDel = [](Obj1 *obj) {
        delete obj;
    };
    using LambdaDel = decltype(lambdaDel);

    uint64_t lambdaDelCount = 0;
    auto lambdaDelComp = [&lambdaDelCount](Obj1 *obj) {
        delete obj;
        ++lambdaDelCount;
    };
    using LambdaDelComp = decltype(lambdaDelComp);

    struct ObjDel
    {
        void operator() (Obj1 *obj) noexcept
        {
            delete obj;
        }
    };

    struct ObjDelComp
    {
        uint64_t count{ 0 };
        void operator() (Obj1 *obj) noexcept
        {
            delete obj;
            ++count;
        }
    };

    DMP_SEP();

    std::cout << "LambdaDel : " << DMP_DECLTYPE_NAME(lambdaDel) << "\n";

    DMP_EXPR1(60, sizeof(Obj1));
    DMP_EXPR1(60, sizeof(Obj1*));
    DMP_EXPR1(60, sizeof(LambdaDel));
    DMP_EXPR1(60, sizeof(lambdaDel));
    DMP_EXPR1(60, sizeof(ObjDel));
    DMP_EXPR1(60, sizeof(LambdaDelComp));
    DMP_EXPR1(60, sizeof(lambdaDelComp));
    DMP_EXPR1(60, sizeof(ObjDelComp));
    DMP_EXPR1(60, sizeof(std::unique_ptr<Obj1>));
    DMP_EXPR1(60, sizeof(std::unique_ptr<Obj1, ObjDel>));
    DMP_EXPR1(60, sizeof(std::unique_ptr<Obj1, LambdaDel>));
    DMP_EXPR1(60, sizeof(std::unique_ptr<Obj1, ObjDelComp>));
    DMP_EXPR1(60, sizeof(std::unique_ptr<Obj1, LambdaDelComp>));
    DMP_EXPR1(60, sizeof(std::unique_ptr<Obj1, void(*)(Obj1*)>));
    DMP_EXPR1(60, sizeof(std::unique_ptr<Obj1, std::function<void(Obj1*)>>));

    ObjDel customDeleter;
    auto simpleUnique = std::make_unique<Obj1>(0);
    std::unique_ptr<Obj1, ObjDel> customDelObj(new Obj1(1), customDeleter);
    std::unique_ptr<Obj1, LambdaDel> lambdaDelObj(new Obj1(2), lambdaDel);
    std::unique_ptr<Obj1, void(*)(Obj1*)> funcDelObj(new Obj1(3), objectDeleter);
    std::unique_ptr<Obj1, std::function<void(Obj1*)>> funcDelObj2(new Obj1(4), objectDeleter);
}
