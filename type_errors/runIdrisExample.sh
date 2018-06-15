#!/bin/bash
mkdir -p errors

idris typeExample0F1.idr -o type0F1.x | tee  errors/error0.log
idris typeExample0F2.idr -o type0F2.x | tee  errors/error1.log
idris typeExample1F1.idr -o type1F1.x | tee  errors/error2.log
idris typeExample1F2.idr -o type1F2.x | tee  errors/error3.log
idris typeExample1F3.idr -o type1F3.x | tee  errors/error4.log
idris typeExample1F4.idr -o type1F4.x | tee  errors/erorr5.log
idris typeExample1F5.idr -o type1F5.x | tee  errors/error6.log

echo "\n\n Final one succeeds : as per a revised version\n"
idris typeExample1W4.idr -o type1W4.x | tee  errors/error7.log
