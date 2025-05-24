@echo off
chcp 65001 >nul
title Chat IA - Ejecutar Aplicación

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🤖 CHAT IA - EJECUTAR                    ║
echo ║              Aplicación de Chat con Modelos LLM             ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Verificar si estamos en el directorio correcto
if not exist "app.py" (
    echo ❌ ERROR: No se encontró app.py
    echo 📁 Asegúrate de ejecutar este script desde el directorio del proyecto
    echo.
    pause
    exit /b 1
)

:: Verificar si existe el entorno virtual
if not exist "venv\Scripts\activate.bat" (
    echo ❌ ERROR: No se encontró el entorno virtual
    echo 🔧 Ejecuta primero install_and_run.bat para instalar la aplicación
    echo.
    pause
    exit /b 1
)

:: Activar entorno virtual
echo 🐍 Activando entorno virtual...
call venv\Scripts\activate.bat

:: Verificar si Streamlit está instalado
streamlit --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Streamlit no está instalado
    echo 📦 Instalando Streamlit...
    pip install streamlit
    if %errorlevel% neq 0 (
        echo ❌ ERROR: No se pudo instalar Streamlit
        pause
        exit /b 1
    )
)

echo ✅ Entorno preparado

:: Preguntar por el puerto
echo.
echo 🌐 Configuración del servidor:
echo.
echo ℹ️  Puerto por defecto: 8501
echo ⚠️  Puertos alternativos: 8502, 8503, 8504, etc.
echo 💡 Si usas puerto 80, necesitarás ejecutar como administrador
echo.
set /p PORT="🔌 Ingresa el puerto a usar (presiona Enter para 8501): "
if "%PORT%"=="" set PORT=8501

:: Verificar puerto especial (80, 443)
if "%PORT%"=="80" (
    echo.
    echo ⚠️  ADVERTENCIA: Puerto 80 requiere permisos de administrador
    echo 🔧 Asegúrate de ejecutar este script como administrador
    echo.
    pause
)

if "%PORT%"=="443" (
    echo.
    echo ⚠️  ADVERTENCIA: Puerto 443 requiere permisos de administrador
    echo 🔧 Asegúrate de ejecutar este script como administrador
    echo.
    pause
)

:: Verificar disponibilidad del puerto
echo.
echo 🔍 Verificando puerto %PORT%...
netstat -an | find ":%PORT% " >nul 2>&1
if %errorlevel% equ 0 (
    echo ⚠️  El puerto %PORT% está en uso
    echo.
    echo 💡 Opciones:
    echo    1. Usar otro puerto (recomendado)
    echo    2. Continuar (puede fallar)
    echo    3. Cancelar
    echo.
    set /p OPTION="Selecciona una opción (1/2/3): "
    
    if "%OPTION%"=="1" (
        set /p PORT="🔌 Ingresa un nuevo puerto: "
        goto :check_port_again
    )
    if "%OPTION%"=="3" (
        echo ❌ Ejecución cancelada
        pause
        exit /b 1
    )
    echo ⚠️  Continuando con puerto ocupado...
) else (
    echo ✅ Puerto %PORT% disponible
)

:check_port_again
echo.
echo 🚀 Iniciando Chat IA...
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                      🎉 APLICACIÓN INICIADA                 ║
echo ║                                                              ║
echo ║  🌐 URL: http://localhost:%PORT%                              ║
echo ║  🔧 Para cambiar puerto: Cierra y ejecuta de nuevo          ║
echo ║  ⏹️  Para detener: Presiona Ctrl+C                          ║
echo ║                                                              ║
echo ║  📊 Modelos disponibles:                                    ║
echo ║     • Qwen 2.5 VL 72B (Conversaciones generales)           ║
echo ║     • Gemma 3 27B (Instrucciones específicas)              ║
echo ║     • DeepSeek R1 Zero (Matemáticas y razonamiento)        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Ejecutar aplicación
streamlit run app.py --server.port %PORT% --server.headless true

echo.
echo 👋 Aplicación cerrada
pause
