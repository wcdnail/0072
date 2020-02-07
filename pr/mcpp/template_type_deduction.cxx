#include "dumps.hxx"
#include <string>
#include <vector>
#include <cmath>

template <typename T> void argPassedByValue(T arg) { _DUMP_FUNCSIGN(T, arg); }
template <typename T> void argPassedByRef(T& arg) { _DUMP_FUNCSIGN(T, arg); }
template <typename T> void argPassedByURef(T&& arg) { _DUMP_FUNCSIGN(T, arg); }

#define _CHECK_LVAL(type, var, init)        \
        type var = init;                    \
        _DUMP_SEP();                        \
        _DUMP_VAR(type, var, init);         \
        argPassedByValue(var);              \
        argPassedByRef(var);                \
        argPassedByURef(var);               \

#define _CHECK_RVAL(type, init)             \
        _DUMP_SEP();                        \
        _DUMP_RVAL(type, init);             \
        argPassedByValue(type{init});       \
        argPassedByRef(type{init});         \
        argPassedByURef(type{init});        \

#define _CHECK_LVAL_ARRAY(type, var, init)  \
        type var[] = init;                  \
        _DUMP_SEP();                        \
        _DUMP_VAR_ARR(type, var, init);     \
        argPassedByValue(var);              \
        argPassedByRef(var);                \
        argPassedByURef(var);               \


void template_type_deduction()
{
    _CHECK_LVAL(int, ix, 27);
    _CHECK_LVAL(const int, cix, 72);
    _CHECK_LVAL(const int&, rix, ix);
    _CHECK_LVAL_ARRAY(const char, charArr, "Boris Johnson");
    _CHECK_LVAL(const char*, charPtr, charArr);
    _CHECK_LVAL(const char* const, ccCharPtr, "const char* const...");
    _CHECK_RVAL(std::string, "Some string");
    using PVFunc = void (*)(void*);
    _CHECK_LVAL(PVFunc, pvfn, nullptr);
    _CHECK_RVAL(std::vector<double>, 256);
}
