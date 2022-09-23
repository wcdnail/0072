#include "stdafx.h"
#include "dumps.hxx"
#include <iostream>
#include <iomanip>
#include <string>
#include <type_traits>

struct NoCtorsAndDtor
{
    int id;
    std::string one;
    std::string two;
};

struct WithDtor
{
    int id;
    std::string one;
    std::string two;

    ~WithDtor() {} // disable move generators
};

struct WithCopyCtor
{
    int id;
    std::string one;
    std::string two;

    WithCopyCtor(const WithCopyCtor &) {}

    WithCopyCtor() {}

    WithCopyCtor(int id1, const std::string &one1, const std::string &two1)
        : id(id1)
        , one(one1)
        , two(two1)
    {
    }
};

struct WithCopyCtorOprtr
{
    int id;
    std::string one;
    std::string two;

    WithCopyCtorOprtr(const WithCopyCtor &) {}
    WithCopyCtorOprtr& operator = (const WithCopyCtorOprtr &) { return *this; }

    WithCopyCtorOprtr() {}

    WithCopyCtorOprtr(int id1, const std::string &one1, const std::string &two1)
        : id(id1)
        , one(one1)
        , two(two1)
    {
    }
};

struct WithMoveCtor
{
    int id;
    std::string one;
    std::string two;

    WithMoveCtor(WithCopyCtor &&) {}

    WithMoveCtor() {}

    WithMoveCtor(int id1, const std::string &one1, const std::string &two1)
        : id(id1)
        , one(one1)
        , two(two1)
    {
    }
};

struct WithMoveCtorOprtr
{
    int id;
    std::string one;
    std::string two;

    WithMoveCtorOprtr(WithMoveCtorOprtr &&) {}
    WithMoveCtorOprtr& operator = (WithMoveCtorOprtr &&) { return *this; }

    WithMoveCtorOprtr() {}

    WithMoveCtorOprtr(int id1, const std::string &one1, const std::string &two1)
        : id(id1)
        , one(one1)
        , two(two1)
    {
    }
};


template <typename Testable>
static void dump(const Testable &obj, const std::string &title)
{
    std::cout << "[" << &obj  << "] : " << title << " { " << obj.id << ", '" << obj.one << "', '" << obj.two << "' }\n";
}

#define DUMP(name) dump(name, #name)

template <typename Testable>
static void copy_move_test_ctors_eq()
{
    Testable init{ 1, "one", "two" };
    Testable moved = std::move(init);
    Testable copied = moved;
    DUMP(init);
    DUMP(moved);
    DUMP(copied);
}

template <typename Testable>
static void move_test_ctors_eq()
{
    Testable init{ 1, "one", "two" };
    Testable moved = std::move(init);
    DUMP(init);
    DUMP(moved);
}

template <typename Testable>
static void copy_move_test()
{
    DMP_SEP();
    constexpr bool movable = std::is_move_assignable<Testable>::value;
    constexpr bool copiable = std::is_copy_assignable<Testable>::value;
    std::cout << DMP_TYPE_NAME(Testable) << " COPY: " << copiable << " MOVE: " << movable << "\n";
    if constexpr (copiable) {
        copy_move_test_ctors_eq<Testable>();
    }
    else if constexpr (movable) {
        move_test_ctors_eq<Testable>();
    }
    else {
        copy_move_test_ctors_eq<Testable>();
    }
}

void autogenerated_ctros_test()
{
    copy_move_test<NoCtorsAndDtor>();
    copy_move_test<WithDtor>();
    copy_move_test<WithCopyCtor>();
    copy_move_test<WithCopyCtorOprtr>();
    copy_move_test<WithMoveCtor>();
    copy_move_test<WithMoveCtorOprtr>();
}