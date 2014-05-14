rem @echo off
rem 转到当前盘符
%~d0
rem 打开当前目录
cd %~dp0
rem 你做的主JAR包的路径
set SOURCEJAR=com.egame.ane.jar
set MainJar=egame.jar
rem 第三方JAR包的路径
set ExternalJar=egame.paysdk.jar
rem 第三方JAR包顶级包名称
set packageName=com
set packageName1=cn
set packageName2=egame
rem swc文件名
set SWC=com.egame.ane.swc
echo =========== start make jar ==============
rem 创建临时目录
md temp
rem 拷贝临时文件
rem copy %SOURCEJAR% %MainJar%
copy .\android-project\bin\%SOURCEJAR% .\temp\%MainJar% >nul
copy .\lib\libs\%ExternalJar% .\temp\ >nul
cd temp
rem 解压第三方包
jar -xf %ExternalJar%
rem 合并主JAR包
rem jar -uf %MainJar% %packageName% 
rem 合并其他顶级包
jar -uf %MainJar% %packageName1%
jar -uf %MainJar% %packageName2%
rem 拷贝过去ane构建目录
copy %MainJar% ..\ane-build-path\android-ARM >nul
cd ..
rd /s/q temp
echo =========== jar make over,start build ane ==============
copy .\actionscript\bin\%SWC% .\ane-build-path >nul
mkdir .\ane-build-path\android-ARM\libs
mkdir .\ane-build-path\android-ARM\libs\armeabi
mkdir .\ane-build-path\android-ARM\libs\armeabi-v7a
copy .\lib\libs\armeabi\libsmsprotocol.so .\ane-build-path\android-ARM\libs\armeabi >nul
copy .\lib\libs\armeabi\libsmsprotocol.so .\ane-build-path\android-ARM\libs\armeabi-v7a >nul
rem copy .\SDK1.2.2\libs\armeabi\libsmsiap.so .\ane-build-path\android-ARM\libs\armeabi-v7a >nul
cd ane-build-path
jar -xf %SWC%
move catalog.xml .\android-ARM\ >nul
move library.swf .\android-ARM\ >nul
echo ===========building ane now ===========================
rem build ane
set FLEX_SDK=D:\AIR_4.0
set FLEX_SDK_BIN= %FLEX_SDK%\bin
set FLEX_LIBS=%FLEX_SDK%\frameworks\libs
java -jar "%FLEX_SDK%\lib\adt.jar" -package -target ane com.egame.ane extension.xml -swc *.swc -platform Android-ARM -C Android-ARM . 
move com.egame.ane ..\ >nul
cd ..
echo =========build complete==========
rem pause>nul