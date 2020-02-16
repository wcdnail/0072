#include "stdafx.h"
#include "dumps.hxx"
#include "traces.hxx"
#include <future>
#include <mutex>
#include <chrono>

void async_1_test()
{
    TRACEMT_FN() << THREAD_ID() << " started...\n";

    auto future1Body = [] (const std::string& name) {
        TRACEMT_FN() << THREAD_ID() << name << ": started\n";
        for (int i = 1; i <= 5; ++i) {
            TRACEMT() << THREAD_ID() << name << ": " << i << "\n";
        }
        TRACEMT() << THREAD_ID() << name << ": done\n";
    };
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future1Body) << " : future1Body (" << sizeof(future1Body) << ")\n";

    auto future1 = std::async(future1Body, "task1");
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future1) << " : future1 (" << sizeof(future1) << ")\n";

    auto future2Body = [&future1Body](auto&& par1) {
        TRACEMT_FN() << THREAD_ID() << par1 << ": started\n";
        for (int i = 1; i <= 5; ++i) {
            TRACEMT() << THREAD_ID() << par1 << ": " << i << "\n";
        }
        TRACEMT() << THREAD_ID() << par1 << ": done\n";
    };
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future2Body) << " : future1Body (" << sizeof(future2Body) << ")\n";

    auto future2 = std::async(std::launch::async | std::launch::deferred, future2Body, "task2");
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future2) << " : future2 (" << sizeof(future2) << ")\n";
}
