#pragma once

#include <iostream>
#include <iomanip>
#include <typeinfo>
#include <boost/type_index.hpp>

#ifdef _MSC_VER
#  define FUNC_DNAME __FUNCSIG__
#else
#  define FUNC_DNAME __PRETTY_FUNCTION__
#endif

constexpr int  DMP_SEP_W = 80;
constexpr int     DMP_LW = 30;

#define DMP_TYPE_NAME(type)                                                                 \
    boost::typeindex::type_id_with_cvr<type>().pretty_name()

#define DMP_DECLTYPE_NAME(var)                                                              \
    DMP_TYPE_NAME(decltype(var))

#define DMP_SEP()                                                                           \
    do {                                                                                    \
        std::cout << std::setfill('-') << std::setw(DMP_SEP_W) << "" << "\n";               \
    } while (0)

#define DMP_RVAL(type, init)                                                                \
    do {                                                                                    \
        std::cout << #type "{ " #init " };\n";                                              \
    } while (0)

#define DMP_VAR(type, var, init)                            \
    do {                                                    \
        std::cout << #type " " #var " = " #init ";\n";      \
    } while (0)

#define DMP_VAR_ARR(type, var, init)                        \
    do {                                                    \
        std::cout << #type " " #var "[] = " #init ";\n";    \
    } while (0)

#define DMP_FNCTX(TT, par)                                                                                                                                                  \
    do {                                                                                                                                                                    \
        using boost::typeindex::type_id_with_cvr;                                                                                                                           \
        std::cout << std::setfill('.') << std::setw(DMP_SEP_W) << std::left << FUNC_DNAME << "\n" << std::setfill(' ')                                                      \
            << std::setw(DMP_LW) << std::right << #TT " : " << type_id_with_cvr<TT>().pretty_name() << "\n"                                                                 \
            << std::setw(DMP_LW) << std::right << "decltype(" #par ") : " << type_id_with_cvr<decltype(par)>().pretty_name() << "\n"                                        \
            << std::setw(DMP_LW) << std::right << "decltype(forward<" #TT ">(" #par ")) : " << type_id_with_cvr<decltype(std::forward<TT>(par))>().pretty_name() << "\n"    \
            << std::setfill('.') << std::setw(DMP_SEP_W) << "" << "\n"                                                                                                      \
            ;                                                                                                                                                               \
    } while (0)
