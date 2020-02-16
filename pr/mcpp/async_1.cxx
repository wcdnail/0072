#include "stdafx.h"
#include "dumps.hxx"
#include "traces.hxx"
#include <future>
#include <mutex>
#include <thread>
#include <chrono>

void async_1_test()
{
    TRACEMT() << THREAD_ID() << FUNC_DNAME " started...\n";

    using namespace std::literals;

    auto future1Body = [] (const char *name) {
        TRACEMT() << THREAD_ID() << FUNC_DNAME " (" << name << "): started\n";
        for (int i = 1; i <= 5; ++i) {
            std::this_thread::sleep_for(10us);
            TRACEMT() << THREAD_ID() << name << ": " << i << "\n";
        }
        TRACEMT() << THREAD_ID() << name << ": done\n";
    };
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future1Body) << " : future1Body (" << sizeof(future1Body) << ")\n";

    auto deferred1 = std::async(std::launch::deferred, future1Body, "deferred1");
    auto future0 = std::async(future1Body, "task0");

    auto future2Body = [&deferred1, &future0](auto&& par1) {
        TRACEMT() << THREAD_ID() << FUNC_DNAME " (" << par1 << "): started\n";
        for (int i = 1; i <= 5; ++i) {
            std::this_thread::sleep_for(10us);
            TRACEMT() << THREAD_ID() << par1 << ": " << i << "\n";
        }
        TRACEMT() << THREAD_ID() << par1 << ": done\n";
        future0.wait();
        deferred1.wait();
    };
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future2Body) << " : future2Body (" << sizeof(future2Body) << ")\n";

    auto future1 = std::async(future1Body, "task1");
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future1) << " : future1 (" << sizeof(future1) << ")\n";

    auto future2 = std::async(std::launch::async | std::launch::deferred, future2Body, "task2");
    TRACEMT() << THREAD_ID() << DMP_DECLTYPE_NAME(future2) << " : future2 (" << sizeof(future2) << ")\n";

    auto deferred2 = std::async(std::launch::deferred, future1Body, "deferred2");
    deferred2.wait();
}
