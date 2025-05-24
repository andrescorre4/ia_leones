@echo off
:: Chat IA - Instalador Rápido de Una Línea
:: Uso: quick_install.bat [puerto]

setlocal enabledelayedexpansion
chcp 65001 >nul

set "DEFAULT_PORT=8501"
set "PORT=%1"
if "%PORT%"=="" set "PORT=%DEFAULT_PORT%"

echo 🚀 Chat IA - Instalación Rápida
echo ================================

:: Verificaciones rápidas
python --version >nul 2>&1 || (echo ❌ Python no encontrado & pause & exit /b 1)
git --version >nul 2>&1 || (echo ❌ Git no encontrado & pause & exit /b 1)

echo ✅ Requisitos verificados
echo 📥 Clonando e instalando...

:: Limpiar directorio si existe
if exist "chat-IA" rmdir /s /q "chat-IA" 2>nul

:: Instalación en una secuencia
git clone https://github.com/Cesde-Suroeste/chat-IA.git && ^
cd chat-IA && ^
python -m venv venv && ^
call venv\Scripts\activate.bat && ^
pip install -r requirements.txt >nul 2>&1 && ^
copy .env.example .env >nul 2>&1 && ^
echo ✅ Instalación completa && ^
echo 🚀 Iniciando en puerto %PORT%... && ^
streamlit run app.py --server.port %PORT%

if %errorlevel% neq 0 (
    echo ❌ Error en la instalación
    pause
    exit /b 1
)

echo 👋 Aplicación cerrada
pause
