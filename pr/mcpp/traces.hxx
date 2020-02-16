#pragma once

#include <sstream>
#include <string>
#include <mutex>
#include <type_traits>

#ifdef _MSC_VER
#  define FUNC_DNAME __FUNCSIG__
#else
#  define FUNC_DNAME __PRETTY_FUNCTION__
#endif

namespace debug
{
    template <typename TP>
    struct TraceBuf
    {
        explicit TraceBuf(const char *file = nullptr, unsigned long long line = 0, const char *fname = nullptr)
            : funcName(fname)
            , sourceFile(file)
            , sourceLine(line)
            , buffer() 
        {
        }

        ~TraceBuf() noexcept
        {
            TP::write(*this);
        }

        const char *funcName;
        const char *sourceFile;
        unsigned long long sourceLine;
        std::ostringstream buffer;
    };

    struct TraceST
    {
        static void write(TraceBuf<TraceST> &buf) noexcept;
    };

    struct TraceMT
    {
        static std::mutex writeMx_;
        static void write(TraceBuf<TraceMT> &buf) noexcept;
    };
}

#define TRACEST()       debug::TraceBuf<debug::TraceST>(__FILE__, __LINE__).buffer
#define TRACEST_FN()    debug::TraceBuf<debug::TraceST>(__FILE__, __LINE__, FUNC_DNAME).buffer
#define TRACEMT()       debug::TraceBuf<debug::TraceMT>(__FILE__, __LINE__).buffer
#define TRACEMT_FN()    debug::TraceBuf<debug::TraceMT>(__FILE__, __LINE__, FUNC_DNAME).buffer
#define THREAD_ID()     "[" << std::this_thread::get_id() << "] "
