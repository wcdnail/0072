@echo off

set VSBLD=build-vc

mkdir %VSBLD%
cd %VSBLD%

rem -DCMAKE_TOOLCHAIN_FILE="%VCPKG_ROOT%/scripts/buildsystems/vcpkg.cmake" ^

@echo on
cmake ^
-DCMAKE_BUILD_TYPE=Debug ^
-G "Visual Studio 15 2017 Win64" ..
@echo off
cd ..

