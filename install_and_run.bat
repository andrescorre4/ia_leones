@echo off
chcp 65001 >nul
title Chat IA - Instalador Automático para Windows 11

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🤖 CHAT IA - INSTALADOR                   ║
echo ║              Aplicación de Chat con Modelos LLM             ║
echo ║                      Windows 11 Ready                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Verificar si Python está instalado
echo [1/7] 🔍 Verificando Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Python no está instalado o no está en PATH
    echo.
    echo 📥 Por favor instala Python desde: https://www.python.org/downloads/
    echo ⚠️  IMPORTANTE: Marca "Add Python to PATH" durante la instalación
    echo.
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo ✅ Python %PYTHON_VERSION% detectado

:: Verificar si Git está instalado
echo [2/7] 🔍 Verificando Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Git no está instalado
    echo.
    echo 📥 Por favor instala Git desde: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

for /f "tokens=3" %%i in ('git --version 2^>^&1') do set GIT_VERSION=%%i
echo ✅ Git %GIT_VERSION% detectado

:: Verificar si el directorio ya existe
echo [3/7] 📁 Verificando directorio del proyecto...
if exist "chat-IA" (
    echo ⚠️  El directorio 'chat-IA' ya existe
    echo.
    set /p OVERWRITE="¿Deseas continuar y actualizar? (s/n): "
    if /i not "%OVERWRITE%"=="s" (
        echo ❌ Instalación cancelada
        pause
        exit /b 1
    )
    echo 🗑️  Eliminando directorio existente...
    rmdir /s /q "chat-IA" 2>nul
)

:: Clonar repositorio
echo [4/7] 📥 Clonando repositorio desde GitHub...
git clone https://github.com/Cesde-Suroeste/chat-IA.git
if %errorlevel% neq 0 (
    echo ❌ ERROR: No se pudo clonar el repositorio
    echo 🌐 Verifica tu conexión a internet
    pause
    exit /b 1
)
echo ✅ Repositorio clonado exitosamente

:: Cambiar al directorio del proyecto
cd chat-IA

:: Crear entorno virtual
echo [5/7] 🐍 Creando entorno virtual...
python -m venv venv
if %errorlevel% neq 0 (
    echo ❌ ERROR: No se pudo crear el entorno virtual
    pause
    exit /b 1
)
echo ✅ Entorno virtual creado

:: Activar entorno virtual e instalar dependencias
echo [6/7] 📦 Instalando dependencias...
call venv\Scripts\activate.bat
pip install --upgrade pip >nul 2>&1
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ❌ ERROR: No se pudieron instalar las dependencias
    pause
    exit /b 1
)
echo ✅ Dependencias instaladas

:: Configurar variables de entorno si no existen
echo [7/7] ⚙️  Configurando variables de entorno...
if not exist ".env" (
    echo 📋 Copiando archivo de configuración...
    copy ".env.example" ".env" >nul
    echo ✅ Archivo .env creado (usando configuración por defecto)
    echo ℹ️  Las API keys ya están preconfiguradas y listas para usar
) else (
    echo ✅ Archivo .env ya existe
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    ✅ INSTALACIÓN COMPLETA                   ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Preguntar por el puerto
echo 🌐 Configuración del servidor:
echo.
echo ℹ️  Puerto por defecto: 8501
echo ⚠️  Si el puerto 8501 está ocupado, puedes usar otro (ej: 8502, 8503, etc.)
echo.
set /p PORT="🔌 Ingresa el puerto a usar (presiona Enter para usar 8501): "
if "%PORT%"=="" set PORT=8501

:: Verificar si el puerto está disponible
echo.
echo 🔍 Verificando disponibilidad del puerto %PORT%...
netstat -an | find ":%PORT% " >nul 2>&1
if %errorlevel% equ 0 (
    echo ⚠️  ADVERTENCIA: El puerto %PORT% parece estar en uso
    echo.
    set /p CONTINUE="¿Deseas continuar de todas formas? (s/n): "
    if /i not "%CONTINUE%"=="s" (
        echo ❌ Ejecución cancelada
        pause
        exit /b 1
    )
) else (
    echo ✅ Puerto %PORT% disponible
)

echo.
echo 🚀 Iniciando Chat IA en puerto %PORT%...
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                      🎉 ¡LISTO PARA USAR!                   ║
echo ║                                                              ║
echo ║  La aplicación se abrirá automáticamente en tu navegador    ║
echo ║  URL: http://localhost:%PORT%                                 ║
echo ║                                                              ║
echo ║  Para detener la aplicación: Presiona Ctrl+C                ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Ejecutar la aplicación
streamlit run app.py --server.port %PORT%

echo.
echo 👋 ¡Gracias por usar Chat IA!
pause
