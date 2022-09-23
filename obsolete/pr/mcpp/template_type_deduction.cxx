#include "stdafx.h"
#include "dumps.hxx"
#include <memory>
#include <string>
#include <vector>
#include <cmath>

template <typename T> void argPassedByValue(T arg) { DMP_FNCTX(T, arg); }
template <typename T> void argPassedByRef(T& arg) { DMP_FNCTX(T, arg); }
template <typename T> void argPassedByURef(T&& arg) { DMP_FNCTX(T, arg); }

template <typename T> void argPassedOverload(T& arg) { DMP_FNCTX(T, arg); }
template <typename T> void argPassedOverload(T&& arg) { DMP_FNCTX(T, arg); }

template <typename T> void argPassedByURef2(T&& arg) { DMP_FNCTX(T, arg); argPassedOverload(arg); }
template <typename T> void argPassedByURef2Move(T&& arg) { DMP_FNCTX(T, arg); argPassedOverload(std::move(arg)); }

#define CHECK_LVALUE(type, var, init)       \
        type var = init;                    \
        DMP_SEP();                          \
        DMP_VAR(type, var, init);           \
        argPassedByValue(var);              \
        argPassedByRef(var);                \
        argPassedByURef(var);               \
        argPassedByURef2(var);              \
        argPassedByURef2Move(var)

#define CHECK_RVALUE(type, init)            \
        DMP_SEP();                          \
        DMP_RVAL(type, init);               \
        argPassedByValue(type{init});       \
        /*argPassedByRef(type{init});*/     \
        argPassedByURef(type{init});        \
        argPassedByURef2(type{init});       \
        argPassedByURef2Move(type{init})

#define CHECK_LVALUE_ARRAY(type, var, init) \
        type var[] = init;                  \
        DMP_SEP();                          \
        DMP_VAR_ARR(type, var, init);       \
        argPassedByValue(var);              \
        argPassedByRef(var);                \
        argPassedByURef(var);               \
        argPassedByURef2(var);              \
        argPassedByURef2Move(var)


void template_type_deduction()
{
    CHECK_LVALUE(int, ix, 27);
    CHECK_LVALUE(const int, cix, 72);
    CHECK_LVALUE(const int&, rix, ix);
    CHECK_LVALUE_ARRAY(const char, charArr, "Boris Johnson");
    CHECK_LVALUE(const char*, charPtr, charArr);
    CHECK_LVALUE(const char* const, ccCharPtr, "const char* const...");
    CHECK_RVALUE(std::string, "Some string");
    using PVFunc = void (*)(void*);
    CHECK_LVALUE(PVFunc, pvfn, nullptr);
    CHECK_RVALUE(std::vector<double>, 256);
    CHECK_RVALUE(int, 1024);
    CHECK_RVALUE(std::unique_ptr<int>, nullptr);
    CHECK_RVALUE(std::shared_ptr<int>, nullptr);
  //CHECK_LVALUE(std::unique_ptr<int>, up1, nullptr); // clang: ошибка: call to deleted constructor of 'std::unique_ptr<int, std::default_delete<int> >'
    CHECK_LVALUE(std::shared_ptr<int>, sp1, nullptr);
}
