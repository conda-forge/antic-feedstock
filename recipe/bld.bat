copy %RECIPE_DIR%\CMakeLists.txt %SRC_DIR%\CMakeLists.txt

mkdir build
cd build

cmake ^
  -G "Ninja" ^
  -DBUILD_TESTING=ON ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DBUILD_SHARED_LIBS=ON ^
  --debug-find ^
  ..

ninja -j%CPU_COUNT%
ninja install

ctest -j%CPU_COUNT% --output-on-failure -E "dump_file"
