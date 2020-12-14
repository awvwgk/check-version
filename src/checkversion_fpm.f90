! This file is part of check-version.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.

!> Check if internal version number matches version number in fpm manifest
module checkversion_fpm
   use tomlf, only : toml_table, toml_parse, toml_error, get_value
   implicit none
   private

   public :: check_fpm_version


   !> Default name of the fpm manifest file
   character(len=*), parameter :: default_manifest = "fpm.toml"

contains


!> Check if internal version number matches version number in fpm manifest
subroutine check_fpm_version(string, manifest, stat)
   !> Version string to be tested
   character(len=*), intent(in), optional :: string
   !> Name of the package manifest file
   character(len=*), intent(in), optional :: manifest
   !> Status of operation
   integer, intent(out), optional :: stat

   character(len=:), allocatable :: file, str
   integer :: unit
   logical :: exist
   type(toml_error), allocatable :: parse_error
   type(toml_table), allocatable :: table

   if (present(manifest)) then
      file = manifest
   else
      file = default_manifest
   end if

   inquire(file=file, exist=exist)

   if (.not.exist) then
      call handle_error(stat)
      return
   end if

   open(file=file, newunit=unit)
   call toml_parse(table, unit, parse_error)
   close(unit)

   if (allocated(parse_error)) then
      call handle_error(stat)
      return
   end if

   call get_value(table, "version", str)

   if (.not.allocated(str)) then
      call handle_error(stat)
      return
   end if

   if (str /= string) then
      call handle_error(stat)
      return
   end if

   if (present(stat)) stat = 0

end subroutine check_fpm_version


!> Handle error scenarios gracefully or by just stopping abruptly
subroutine handle_error(stat)
   !> Status of operation
   integer, intent(out), optional :: stat

   if (present(stat)) then
      stat = 1
   else
      error stop
   end if

end subroutine handle_error


end module checkversion_fpm
