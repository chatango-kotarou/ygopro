solution "ygo"
    location "build"
    language "C++"
    objdir "obj"

    configurations { "Debug", "Release" }

    configuration "windows"
        defines { "WIN32", "_WIN32", "WINVER=0x0501" }

    configuration "bsd"
        defines { "LUA_USE_POSIX" }
        includedirs { "/usr/local/include" }
        libdirs { "/usr/local/lib" }

    configuration "macosx"
        defines { "LUA_USE_MACOSX" }
        includedirs { "/usr/local/include/*" }
        libdirs { "/usr/local/lib", "/usr/X11/lib" }
        buildoptions { "-stdlib=libc++" }
        links {"OpenGL.framework","Cocoa.framework","IOKit.framework"}

    configuration "linux"
        defines { "LUA_USE_LINUX" }

    configuration "vs*"
        flags "EnableSSE2"
        buildoptions { "-wd4996" }
        defines { "_CRT_SECURE_NO_WARNINGS" }

    configuration "not vs*"
        buildoptions { "-fno-strict-aliasing", "-Wno-multichar" }
    configuration {"not vs*", "windows"}
        buildoptions { "-static-libgcc" }

    configuration "Debug"
        flags "Symbols"
        defines "_DEBUG"
        targetdir "bin/debug"

    configuration { "Release", "not vs*" }
        flags "Symbols"
        defines "NDEBUG"
        buildoptions "-march=native"

    configuration { "Release", "vs*" }
        flags { "StaticRuntime", "LinkTimeOptimization" }

    configuration { "Debug", "vs*" }
        defines { "_ITERATOR_DEBUG_LEVEL=0" }

    configuration "Release"
        flags { "OptimizeSpeed" }
        targetdir "bin/release"

    include "ocgcore"
    include "gframe"
    if os.is("windows") then
    include "event"
    include "freetype"
    include "irrlicht"
    include "lua"
    include "sqlite3"
    end
