program json_demo
    use json_module, wp => json_RK, IK => json_IK, LK => json_LK, CK => json_CK
    use, intrinsic :: iso_fortran_env , only: error_unit, output_unit 
    implicit none


    character(len=*),parameter  :: dir= './'     !! working directory
    character(len=*),parameter  :: filename0= 'test.json'     !! file to read
    type(json_file) :: json     !! the JSON structure read from the file
    type(json_value),pointer :: p !! a pointer for low-level manipulations
    type(json_core) :: core       !! factory for manipulating `json_value` pointers
    integer :: error_cnt
    logical(LK) :: found

    real(wp),dimension(:),allocatable :: SolutionVars
    ! character(kind=CK,len=50),dimension(:),allocatable :: files
    integer(IK) :: date_i

    ! dir = '../../files/inputs/'
    ! filename0 = 'test1.json'
    allocate(SolutionVars(100))
    error_cnt = 0
    call json%initialize()
    if (json%failed()) then
        call json%print_error_message(error_unit)
        error_cnt = error_cnt + 1
    end if
                                                                                        
    ! parse the json file:
    write(error_unit,'(A)') ''
    write(error_unit,'(A)') 'parsing file '//dir//filename0

    call json%load_file(filename = dir//filename0)
    if (json%failed()) then
        call json%print_error_message(error_unit)
        error_cnt = error_cnt + 1
    end if

 
    call json%get('Int',date_i)
    write(*,*) date_i



    write(*,*) 'before initialize'
    call core%initialize(compress_vectors=.true.)
    if(core%failed()) then
        call core%print_error_message(error_unit)
    end if
    write(*,*) 'before get root'
    call json%get(p) ! get root
    ! write(*,*) p
    if (json%failed()) then
        call json%print_error_message(error_unit)
        error_cnt = error_cnt + 1
    end if
    !方法1
    ! call json%get('SolutionVars', SolutionVars,found)
    ! if (json%failed()) then
    !     call json%print_error_message(error_unit)
    !     error_cnt = error_cnt + 1
    ! end if

    ! if(found) then
    !     write(*,*) SolutionVars(1)
    ! end if

    ! !方法2
    write(*,*) 'method2'
    call core%get(p,'SolutionVars',SolutionVars,found)
    ! if(core%failed()) then
    !     call core%print_error_message(error_unit)
    ! end if

    ! if(found) then
    !     write(*,*) SolutionVars(1)
    ! end if

end program
