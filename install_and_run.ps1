# Chat IA - Instalador Automático PowerShell para Windows 11
# Ejecutar con: PowerShell -ExecutionPolicy Bypass -File install_and_run.ps1

param(
    [int]$Port = 8501,
    [switch]$SkipPortCheck,
    [switch]$Force
)

# Configurar consola
$Host.UI.RawUI.WindowTitle = "Chat IA - Instalador PowerShell"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Colores
$ErrorColor = "Red"
$SuccessColor = "Green"
$WarningColor = "Yellow"
$InfoColor = "Cyan"

function Write-Step {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Write-Header {
    Clear-Host
    Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                    🤖 CHAT IA - INSTALADOR                   ║" -ForegroundColor Cyan
    Write-Host "║              Aplicación de Chat con Modelos LLM             ║" -ForegroundColor Cyan
    Write-Host "║                    PowerShell Edition                       ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

function Test-Port {
    param([int]$PortNumber)
    try {
        $listener = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
        $activePorts = $listener.GetActiveTcpListeners() | Where-Object { $_.Port -eq $PortNumber }
        return $activePorts.Count -eq 0
    }
    catch {
        return $true
    }
}

function Get-AvailablePort {
    param([int]$StartPort = 8501)
    for ($i = $StartPort; $i -lt $StartPort + 100; $i++) {
        if (Test-Port -PortNumber $i) {
            return $i
        }
    }
    return $StartPort
}

# Mostrar header
Write-Header

# Verificar Python
Write-Step "[1/7] 🔍 Verificando Python..." $InfoColor
if (-not (Test-Command "python")) {
    Write-Step "❌ ERROR: Python no está instalado o no está en PATH" $ErrorColor
    Write-Step ""
    Write-Step "📥 Por favor instala Python desde: https://www.python.org/downloads/" $WarningColor
    Write-Step "⚠️  IMPORTANTE: Marca 'Add Python to PATH' durante la instalación" $WarningColor
    Write-Step ""
    Read-Host "Presiona Enter para salir"
    exit 1
}

$pythonVersion = python --version 2>&1
Write-Step "✅ $pythonVersion detectado" $SuccessColor

# Verificar Git
Write-Step "[2/7] 🔍 Verificando Git..." $InfoColor
if (-not (Test-Command "git")) {
    Write-Step "❌ ERROR: Git no está instalado" $ErrorColor
    Write-Step ""
    Write-Step "📥 Por favor instala Git desde: https://git-scm.com/download/win" $WarningColor
    Write-Step ""
    Read-Host "Presiona Enter para salir"
    exit 1
}

$gitVersion = git --version 2>&1
Write-Step "✅ $gitVersion detectado" $SuccessColor

# Verificar directorio existente
Write-Step "[3/7] 📁 Verificando directorio del proyecto..." $InfoColor
if (Test-Path "chat-IA") {
    Write-Step "⚠️  El directorio 'chat-IA' ya existe" $WarningColor
    if (-not $Force) {
        $overwrite = Read-Host "¿Deseas continuar y actualizar? (s/n)"
        if ($overwrite -ne "s" -and $overwrite -ne "S") {
            Write-Step "❌ Instalación cancelada" $ErrorColor
            Read-Host "Presiona Enter para salir"
            exit 1
        }
    }
    Write-Step "🗑️  Eliminando directorio existente..." $WarningColor
    Remove-Item -Path "chat-IA" -Recurse -Force -ErrorAction SilentlyContinue
}

# Clonar repositorio
Write-Step "[4/7] 📥 Clonando repositorio desde GitHub..." $InfoColor
try {
    git clone https://github.com/Cesde-Suroeste/chat-IA.git 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Git clone failed" }
    Write-Step "✅ Repositorio clonado exitosamente" $SuccessColor
}
catch {
    Write-Step "❌ ERROR: No se pudo clonar el repositorio" $ErrorColor
    Write-Step "🌐 Verifica tu conexión a internet" $WarningColor
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Cambiar al directorio
Set-Location "chat-IA"

# Crear entorno virtual
Write-Step "[5/7] 🐍 Creando entorno virtual..." $InfoColor
try {
    python -m venv venv 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Venv creation failed" }
    Write-Step "✅ Entorno virtual creado" $SuccessColor
}
catch {
    Write-Step "❌ ERROR: No se pudo crear el entorno virtual" $ErrorColor
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Activar entorno virtual e instalar dependencias
Write-Step "[6/7] 📦 Instalando dependencias..." $InfoColor
try {
    & "venv\Scripts\Activate.ps1"
    python -m pip install --upgrade pip 2>&1 | Out-Null
    pip install -r requirements.txt 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Pip install failed" }
    Write-Step "✅ Dependencias instaladas" $SuccessColor
}
catch {
    Write-Step "❌ ERROR: No se pudieron instalar las dependencias" $ErrorColor
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Configurar variables de entorno
Write-Step "[7/7] ⚙️  Configurando variables de entorno..." $InfoColor
if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env" -ErrorAction SilentlyContinue
    Write-Step "✅ Archivo .env creado (usando configuración por defecto)" $SuccessColor
    Write-Step "ℹ️  Las API keys ya están preconfiguradas y listas para usar" $InfoColor
} else {
    Write-Step "✅ Archivo .env ya existe" $SuccessColor
}

Write-Step ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    ✅ INSTALACIÓN COMPLETA                   ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Step ""

# Configurar puerto
Write-Step "🌐 Configuración del servidor:" $InfoColor
Write-Step ""
Write-Step "ℹ️  Puerto especificado: $Port" $InfoColor

if (-not $SkipPortCheck) {
    if (-not (Test-Port -PortNumber $Port)) {
        Write-Step "⚠️  El puerto $Port está en uso" $WarningColor
        $availablePort = Get-AvailablePort -StartPort $Port
        Write-Step "💡 Puerto disponible sugerido: $availablePort" $InfoColor
        
        $useAlternative = Read-Host "¿Usar puerto $availablePort? (s/n, Enter=sí)"
        if ($useAlternative -eq "" -or $useAlternative -eq "s" -or $useAlternative -eq "S") {
            $Port = $availablePort
        }
    } else {
        Write-Step "✅ Puerto $Port disponible" $SuccessColor
    }
}

Write-Step ""
Write-Step "🚀 Iniciando Chat IA en puerto $Port..." $InfoColor
Write-Step ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                      🎉 ¡LISTO PARA USAR!                   ║" -ForegroundColor Green
Write-Host "║                                                              ║" -ForegroundColor Green
Write-Host "║  La aplicación se abrirá automáticamente en tu navegador    ║" -ForegroundColor Green
Write-Host "║  URL: http://localhost:$Port                                  ║" -ForegroundColor Green
Write-Host "║                                                              ║" -ForegroundColor Green
Write-Host "║  Para detener la aplicación: Presiona Ctrl+C                ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Step ""

# Ejecutar aplicación
try {
    streamlit run app.py --server.port $Port
}
catch {
    Write-Step "❌ Error al ejecutar la aplicación" $ErrorColor
    Write-Step "🔧 Verifica que todas las dependencias estén instaladas" $WarningColor
}

Write-Step ""
Write-Step "👋 ¡Gracias por usar Chat IA!" $InfoColor
Read-Host "Presiona Enter para salir"
