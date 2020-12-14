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

!> Version of the versioning package
module checkversion_version
   implicit none
   private

   public :: checkversion_version_string, checkversion_version_compact
   public :: get_checkversion_version


   !> String representation of the check-version version
   character(len=*), parameter :: checkversion_version_string = "0.1.0"

   !> Numeric representation of the check-version version
   integer, parameter :: checkversion_version_compact(3) = [0, 1, 0]


contains


!> Getter function to retrieve check-version version
subroutine get_checkversion_version(major, minor, patch, string)

   !> Major version number of the check-version version
   integer, intent(out), optional :: major

   !> Minor version number of the check-version version
   integer, intent(out), optional :: minor

   !> Patch version number of the check-version version
   integer, intent(out), optional :: patch

   !> String representation of the check-version version
   character(len=:), allocatable, intent(out), optional :: string

   if (present(major)) then
      major = checkversion_version_compact(1)
   end if
   if (present(minor)) then
      minor = checkversion_version_compact(2)
   end if
   if (present(patch)) then
      patch = checkversion_version_compact(3)
   end if
   if (present(string)) then
      string = checkversion_version_string
   end if

end subroutine get_checkversion_version


end module checkversion_version
