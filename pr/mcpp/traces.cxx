#include "stdafx.h"
#include "traces.hxx"
#include <iostream>
#include <iomanip>

namespace debug
{
    std::mutex TraceMT::writeMx_;

    void TraceST::write(TraceBuf<TraceST> &buf)
    {
        auto text = buf.buffer.str();
        std::cout << text;
#ifdef _WIN32
        ::OutputDebugStringA(text.c_str());
#endif
    }

    void TraceMT::write(TraceBuf<TraceMT> &buf)
    {
        std::lock_guard lock(writeMx_);
        TraceST::write(reinterpret_cast<TraceBuf<TraceST>&>(buf));
    }
}
