# build-glibc

A container to help build other containers when compiling binaries. See the
`build` container to build for `musl` based systems.

## supported languages

- C
  - compile example: `cc -o hello hello.c`

- C++
  - compile example: `g++ -o hello hello.cc`

- Rust
  - compile example: `rustc hello.rs`

The following languages can be compiled with this container if additional
dependencies are installed.

- Ada
  - install dependencies: `apt install gnat`
  - compile example: `gnatmake hello.adb`

- D
  - install dependencies: `apt install gdc`
  - compile example: `gdc -o hello hello.d`

- Fortran
  - install dependencies: `apt install gfortran`
  - compile example: `gfortran -o hello hello.f90`

- Go
  - install dependencies: `apt install gccgo`
  - compile example: `gccgo -o hello hello.go`

- Objective-C
  - install dependencies: `apk install gobjc gnustep-devel`
  - compile example: `gcc $(gnustep-config --objc-flags) -o hello hello.m -lobjc -lgnustep-base`

- Objective-C++
  - install dependencies: `apk install gobjc++ gnustep-devel`
  - compile example: `g++ $(gnustep-config --objc-flags) -o hello hello.mm -lobjc -lgnustep-base`

## included binaries

NOTE: None of the binaries are exposed for use outside of the `build-glibc`
container.

### build-base

- addr2line
- ar
- as
- c++
- c++filt
- c89
- c99
- cc
- cpp
- dwp
- elfedit
- g++
- gcc
- gcc-ar
- gcc-nm
- gcc-ranlib
- gcov
- gcov-dump
- gcov-tool
- gprof
- ld
- ld.bfd
- lto-dump
- make
- nm
- objcopy
- objdump
- patch
- ranlib
- readelf
- size
- strings
- strip

### Rust/Cargo

- cargo
- cargo-clippy
- cargo-fmt
- cargo-miri
- clippy-driver
- rls
- rust-analyzer
- rust-gdb
- rust-gdbgui
- rust-lldb
- rustc
- rustdoc
- rustfmt
- rustup
