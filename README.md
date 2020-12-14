# Check version numbers for your projects

Keep your version numbers consistent between your source code and project files.


## Usage

This is an *fpm*-enabled project, checkout the [Fortran package manager](https://github.com/fortran-lang/fpm) for more details.
To actually use this package in your project, include a dependency on ``check-version`` with:

```toml
[dependencies]
[dependencies.check-version]
git = "https://github.com/awvwgk/check-version"
```

Now you can use the ``checkversion`` module in your unit tests.
To check if the version number in your package manifest (``fpm.toml``) is consistent with the version in your source code, include a simple unit test like this

```f90
program test_version
  use checkversion, only : check_fpm_version
  use myproj_version, only : get_version  ! Use your own version module here
  implicit none
  character(len=:), allocatable :: version

  call get_version(string=version)  ! Use your own procedure here
  call check_fpm_version(string=version)

end program test_version
```


## License

Licensed under the Apache License, Version 2.0 (the “License”);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an *“as is” basis*,
*without warranties or conditions of any kind*, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Unless you explicitly state otherwise, any contribution intentionally
submitted for inclusion in this project by you, as defined in the
Apache-2.0 license, shall be licensed as above, without any additional
terms or conditions.
