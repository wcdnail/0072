#include "stdafx.h"

struct Over1
{
    template <typename T>
    explicit Over1(T&& par1)
        : str1(std::forward<T>(par1))
    {
        std::cout << "UC\n";
    }

    Over1(const Over1& rhs)
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
    Over1 moved1("text moved");
    Over1 cloned1 = clone(moved1);
    Over1 cloned2 = clone_fwd(cloned1);
  //Over1 cloned3 = clone(Over1(std::string("rvalue1")));       // ERROR
  //Over1 cloned4 = clone_fwd(Over1(std::string("rvalue2")));   // ERROR
    DUMP_OVERLOAD(moved1);
    DUMP_OVERLOAD(cloned1);
    DUMP_OVERLOAD(cloned2);
}
