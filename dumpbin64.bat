@echo off
setlocal

if "%1" == "" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    set "CMAKE_BINARY_DIR=cmake-build-release-x64"
) else (
    set "CMAKE_BINARY_DIR=%1"
)
set "DUMPBIN_DIR=%CMAKE_BINARY_DIR:build=dump%"

pushd %~dp0
mkdir %DUMPBIN_DIR%

pushd %DUMPBIN_DIR%

    dumpbin /headers ..\%CMAKE_BINARY_DIR%\lpeg.dll > lpeg.dll.headers.txt
    dumpbin /exports ..\%CMAKE_BINARY_DIR%\lpeg.dll > lpeg.dll.exports.txt
    dumpbin /dependents ..\%CMAKE_BINARY_DIR%\lpeg.dll > lpeg.dll.dependents.txt
    dumpbin /imports ..\%CMAKE_BINARY_DIR%\lpeg.dll > lpeg.dll.imports.txt

popd
popd

endlocal
