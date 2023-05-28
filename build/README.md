# build

A container to help build other containers when compiling binaries. See the
`build-glibc` container to build for `glibc` based systems.

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
  - install dependencies: `apk add gcc-gnat`
  - compile example: `gnatmake hello.adb`

- D
  - install dependencies: `apk add gcc-gdc`
  - compile example: `gdc -o hello hello.d`

- Fortran
  - install dependencies: `apk add gfortran`
  - compile example: `gfortran -o hello hello.f90`

- Go
  - install dependencies: `apk add gcc-go`
  - compile example: `go build hello.go`

- Objective-C
  - install dependencies: `apk add gcc-objc`
  - NOTE: GNUstep is also required but **not** available in the Alpine Linux
    repositories. See <https://gnustep.github.io/> for build information.

## included binaries

NOTE: None of the binaries are exposed for use outside of the `build` container.

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
- file
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
- rust-gdb
- rust-gdbgui
- rust-lldb
- rustc
- rustdoc
- rustfmt
- rustup
