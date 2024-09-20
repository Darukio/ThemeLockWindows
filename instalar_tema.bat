@echo off
setlocal

:: Ruta a los archivos .bat y .deskthemepack
set "rutaScriptHabilitar=%~dp0\scripts\HabilitarCambioFondoPantallaTema.bat"
set "rutaTema=%~dp0\temas\"
set "rutaScriptDeshabilitar=%~dp0\scripts\DeshabilitarCambioFondoPantallaTema.bat"

:: Ejecutar el primer archivo .bat sin abrir nueva ventana
echo Ejecutando el primer archivo .bat...
cscript //nologo "%~dp0\scripts\EjecutarSilencioso.vbs" "%rutaScriptHabilitar%"

:: Instalar el tema de escritorio
echo Instalando el tema de escritorio...
start "" "%rutaTema%"

:: Esperar un tiempo para asegurar que el tema se haya instalado correctamente
echo Esperando a que el tema se instale.
timeout /t 5 /nobreak > nul

:: Ejecutar el segundo archivo .bat sin abrir nueva ventana
echo Ejecutando el segundo archivo .bat...
cscript //nologo "%~dp0\scripts\EjecutarSilencioso.vbs" "%rutaScriptDeshabilitar%"

:: Esperar una respuesta del usuario
echo El proceso ha terminado.
pause

endlocal
