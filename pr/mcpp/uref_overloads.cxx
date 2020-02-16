#include "stdafx.h"
#include <type_traits>

struct BadExample1
{
    template <typename T>
    explicit BadExample1(T&& par1) 
        : str1(std::forward<T>(par1)) 
    {
        std::cout << "BUC : " << str1 << "\n";
    }
    BadExample1(const BadExample1& rhs) : str1(rhs.str1) 
    {
        std::cout << "BCC : " << str1 << "\n";
    }
    const std::string& toString() const { return str1; }

    std::string str1;
};

struct NotBadExample1
{
    template <typename T, 
              typename = std::enable_if_t<!std::is_same<NotBadExample1, std::decay_t<T>>::value>>
    explicit NotBadExample1(T&& par1) 
        : str1(std::forward<T>(par1))
    {
        std::cout << "NBUC : " << str1 << "\n";
    }
    NotBadExample1(const NotBadExample1& rhs) : str1(rhs.str1) 
    {
        std::cout << "NBCC : " << str1 << "\n";
    }
    const std::string& toString() const { return str1; }

    std::string str1;
};


template <typename T, typename... Args>
static T clone(T&& obj, Args&&... args)
{
    return T(obj, std::forward<Args>(args)...);
}

template <typename T, typename... Args>
static T clone_fwd(T&& obj, Args&&... args)
{
    return T(std::forward<T>(obj), std::forward<Args>(args)...);
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
  //BadExample1 cloned12 = clone(std::move(moved1));                        // ERROR
    BadExample1 cloned2 = clone_fwd(cloned1);
  //BadExample1 cloned3 = clone(BadExample1("rvalue1"));                    // ERROR
  //BadExample1 cloned4 = clone_fwd(BadExample1("rvalue2"));                // ERROR
    NotBadExample1 cloned5 = clone(NotBadExample1("rvalue1"));
    NotBadExample1 cloned6 = clone_fwd(NotBadExample1("rvalue2"));
    NotBadExample1 cloned7 = clone_fwd(std::move(cloned5));
    NotBadExample1 moved2 = std::move(clone_fwd(std::move(cloned6)));
    DUMP_OVERLOAD(moved1);
    DUMP_OVERLOAD(cloned1);
    DUMP_OVERLOAD(cloned2);
    DUMP_OVERLOAD(cloned5);
    DUMP_OVERLOAD(cloned6);
    DUMP_OVERLOAD(cloned7);
    DUMP_OVERLOAD(moved2);
}
