#pragma once

#include <sstream>
#include <string>
#include <mutex>
#include <type_traits>

namespace debug
{
    template <typename TP>
    struct TraceBuf;

    struct TraceST
    {
        static void write(TraceBuf<TraceST> &buf);
    };

    struct TraceMT
    {
        static std::mutex writeMx_;
        static void write(TraceBuf<TraceMT> &buf);
    };

    template <typename TP>
    struct TraceBuf
    {
        TraceBuf(const char *file, unsigned long long line)
            : sourceFile(file)
            , sourceLine(line)
            , buffer() 
        {
        }

        ~TraceBuf() 
        {
            TP::write(*this);
        }

        const char *sourceFile;
        unsigned long long sourceLine;
        std::ostringstream buffer;
    };
}

#define TRACEST()   debug::TraceBuf<debug::TraceST>(__FILE__, __LINE__).buffer
#define TRACEMT()   debug::TraceBuf<debug::TraceMT>(__FILE__, __LINE__).buffer
#define THREAD_ID() "[" << std::this_thread::get_id() << "] "