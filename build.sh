#!/bin/bash
JSON_PATH=/mnt/d/fortran/Autocal/AutoCal_Fortran/third_part/json_install/jsonfortran-gnu-7.1.0/lib 

# gfortran main.f90 -I$JSON_PATH -L$JSON_PATH -ljsonfortran -o json_test
gfortran main.f90 -g -I$JSON_PATH -L$JSON_PATH $JSON_PATH/libjsonfortran.a -o json_test

