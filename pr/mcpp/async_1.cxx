#include "stdafx.h"
#include "dumps.hxx"
#include "traces.hxx"
#include <future>
#include <mutex>
#include <chrono>

void async_1_test()
{
    auto future1Body = [] (const std::string &name) {
        for (int i = 1; i <= 5; ++i) {
            TRACEMT() << THREAD_ID() << name << ": " << i << "\n";
        }
        TRACEMT() << THREAD_ID() << name << ": done\n";
    };
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future1Body) << " : future1Body " << sizeof(future1Body) << "\n";
    auto future1 = std::async(future1Body, "task1");
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future1) << " : future1 " << sizeof(future1) << "\n";
}
