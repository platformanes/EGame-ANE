rem @echo off
rem ת����ǰ�̷�
%~d0
rem �򿪵�ǰĿ¼
cd %~dp0
rem ��������JAR����·��
set SOURCEJAR=com.egame.ane.jar
set MainJar=egame.jar
rem ������JAR����·��
set ExternalJar=egame.paysdk.jar
rem ������JAR������������
set packageName=com
set packageName1=cn
set packageName2=egame
rem swc�ļ���
set SWC=com.egame.ane.swc
echo =========== start make jar ==============
rem ������ʱĿ¼
md temp
rem ������ʱ�ļ�
rem copy %SOURCEJAR% %MainJar%
copy .\android-project\bin\%SOURCEJAR% .\temp\%MainJar% >nul
copy .\lib\libs\%ExternalJar% .\temp\ >nul
cd temp
rem ��ѹ��������
jar -xf %ExternalJar%
rem �ϲ���JAR��
rem jar -uf %MainJar% %packageName% 
rem �ϲ�����������
jar -uf %MainJar% %packageName1%
jar -uf %MainJar% %packageName2%
rem ������ȥane����Ŀ¼
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