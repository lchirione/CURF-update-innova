@echo off
title ACTUALIZACION INNOVA

echo -------------------------------------
echo -- Moviendo los modulos localmente --
echo -------------------------------------

REM Establece la carpeta origen y la carpeta destino
set "origen=C:\Update-Innova\Repositorio"
set "destino=C:\TEMP-INNOVA"

REM Elimina la carpeta destino si existe
if exist "%destino%" rmdir /S /Q "%destino%"

REM Crea la carpeta destino
mkdir "%destino%"

REM Copia todas las carpetas del directorio origen y sus subdirectorios al directorio destino
xcopy "%origen%\*" "%destino%" /E

echo -------------------------------------
echo --- Modulos movidos exitosamente ----
echo -------------------------------------

REM Mensaje de alerta para el usuario

echo CreateObject("WScript.Shell").Popup "Se va actualizar Innova. Evitar usar el equipo", 5, "CURF - ACTUALIZACION INNOVA", 0 + 48 > "%temp%\alert-innova.vbs"
wscript "%temp%\alert-innova.vbs"
del "%temp%\alert-innova.vbs"

REM Detiene Innova
TASKKILL /F /IM nombre_del_programa.exe

echo -------------------------------------
echo -------- Se detuvo innova -----------
echo -------------------------------------

REM Establece la carpeta origen y la carpeta destino
set "origen=C:\TEMP-INNOVA"
set "destino=C:\test"

REM Elimina los subdirectorios de la carpeta destino que coincidan con los nombres de las carpetas del directorio origen
for /D %%D in ("%origen%\*") do rd /S /Q "%destino%\%%~nxD"

REM Copia todas las carpetas y subdirectorios del directorio origen al directorio destino
xcopy /Y "%origen%\*" "%destino%" /E

echo -------------------------------------
echo ---- Se reemplazaron los modulos ----
echo -------------------------------------

REM Eliminar carpeta origen "TEMP-INNOVA"
rmdir /S /Q "%origen%"

echo -------------------------------------
echo - Se elimino la carpeta TEMP-INNOVA -
echo -------------------------------------

REM Mensaje de alerta para el usuario

echo CreateObject("WScript.Shell").Popup "Innova se actualizo correctamente", 10000, "CURF - ACTUALIZACION INNOVA", 0 + 64 > "%temp%\alert-innova.vbs"
wscript "%temp%\alert-innova.vbs"
del "%temp%\alert-innova.vbs"


redir > C:\test\log-update-innova.txt
exit