#include "stdafx.h"

struct BadExample1
{
    template <typename T>
    explicit BadExample1(T&& par1)
        : str1(std::forward<T>(par1))
    {
        std::cout << "UC\n";
    }

    BadExample1(const BadExample1& rhs)
        : str1(rhs.str1)
    {
        std::cout << "CC\n";
    }

    const std::string& toString() const { return str1; }

    std::string str1;
};

template <typename T>
static T clone(T&& obj)
{
    T cln(obj);
    return cln;
}

template <typename T>
static T clone_fwd(T&& obj)
{
    T cln(std::forward<T>(obj));
    return cln;
}


template <typename T>
static void dump_overload(T&& obj, const std::string &name)
{
    std::cout << name << " : " << obj.toString() << "\n";
}

#define DUMP_OVERLOAD(var) dump_overload(var, #var)

void uref_overloads()
{
    BadExample1 moved1("text moved");
    BadExample1 cloned1 = clone(moved1);
    BadExample1 cloned2 = clone_fwd(cloned1);
  //BadExample1 cloned3 = clone(BadExample1(std::string("rvalue1")));       // ERROR
  //BadExample1 cloned4 = clone_fwd(BadExample1(std::string("rvalue2")));   // ERROR
    DUMP_OVERLOAD(moved1);
    DUMP_OVERLOAD(cloned1);
    DUMP_OVERLOAD(cloned2);
}
