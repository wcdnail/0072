#include "stdafx.h"
#include "traces.hxx"
#include <iostream>
#include <iomanip>

#ifdef _WIN32
#  define WIN32_DEBUG_OUTPUTA(text) OutputDebugStringA(text)
#else
#  define WIN32_DEBUG_OUTPUTA(text)
#endif

#define ON_FATAL()                                              \
    do {                                                        \
        static const char title[] = FUNC_DNAME ": FAILED!\n";   \
        fputs(title, stderr);                                   \
        WIN32_DEBUG_OUTPUTA(title);                             \
    } while (0)


namespace debug
{
    std::mutex TraceMT::writeMx_;

    void TraceST::write(TraceBuf<TraceST> &buf) noexcept
    {
        try {
            std::ostringstream text;
            if (buf.sourceFile) {
                text << buf.sourceFile << "(" << buf.sourceLine << "): ";
            }
            if (buf.funcName) {
                text << "[" << buf.funcName << "] ";
            }
            text << buf.buffer.str();
            auto output = text.str();
            std::cout << output << std::flush;
            WIN32_DEBUG_OUTPUTA(output.c_str());
        }
        catch (...) { // something went wrong
            ON_FATAL();
        }
    }

    void TraceMT::write(TraceBuf<TraceMT> &buf) noexcept
    {
        try {
            std::lock_guard lock(writeMx_);
            TraceST::write(reinterpret_cast<TraceBuf<TraceST>&>(buf));
        }
        catch (...) { // something went wrong
            ON_FATAL();
        }
    }
}
