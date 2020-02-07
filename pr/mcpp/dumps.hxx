#pragma once

#include <iostream>
#include <iomanip>
#include <typeinfo>
#include <boost/type_index.hpp>

#ifdef _MSC_VER
#  define __FUNCNAME__ __FUNCSIG__
#else
#  define __FUNCNAME__ __PRETTY_FUNCTION__
#endif

static const int _DUMP_SEP_W = 140;
static const int    _DUMP_LW = 35;

#define _DUMP_SEP()                                                                         \
    do {                                                                                    \
        std::cout << std::setfill('-') << std::setw(_DUMP_SEP_W) << "" << "\n";             \
    } while (0)

#define _DUMP_RVAL(type, init)                                                              \
    do {                                                                                    \
        std::cout << #type "{ " #init " };\n";                                              \
    } while (0)

#define _DUMP_VAR(type, var, init)                          \
    do {                                                    \
        std::cout << #type " " #var " = " #init ";\n";      \
    } while (0)

#define _DUMP_VAR_ARR(type, var, init)                      \
    do {                                                    \
        std::cout << #type " " #var "[] = " #init ";\n";    \
    } while (0)

#define _DUMP_FUNCSIGN(TT, par)                                                                                                                                             \
    do {                                                                                                                                                                    \
        using boost::typeindex::type_id_with_cvr;                                                                                                                           \
        std::cout << std::setfill('.') << std::setw(_DUMP_SEP_W) << std::left <<   __FUNCNAME__ << "\n" << std::setfill(' ')                                                \
            << std::setw(_DUMP_LW) << std::right << #TT " : " << type_id_with_cvr<TT>().pretty_name() << "\n"                                                               \
            << std::setw(_DUMP_LW) << std::right << "decltype(" #par ") : " << type_id_with_cvr<decltype(par)>().pretty_name() << "\n"                                      \
            << std::setw(_DUMP_LW) << std::right << "decltype(forward<" #TT ">(" #par ")) : " << type_id_with_cvr<decltype(std::forward<TT>(par))>().pretty_name() << "\n"  \
            ;                                                                                                                                                               \
    } while (0)
