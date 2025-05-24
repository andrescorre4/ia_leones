# 🚀 Scripts de Instalación Automática - Chat IA

Este proyecto incluye varios scripts para facilitar la instalación y ejecución en Windows 11.

## 📋 Scripts Disponibles

### 1. **install_and_run.bat** (Recomendado)
**Instalador completo con interfaz amigable**

```cmd
install_and_run.bat
```

**Características:**
- ✅ Verificación completa de requisitos
- ✅ Interfaz visual con colores
- ✅ Detección automática de puertos ocupados
- ✅ Configuración automática de variables de entorno
- ✅ Manejo de errores detallado

### 2. **run.bat**
**Solo para ejecutar (después de instalar)**

```cmd
run.bat
```

**Características:**
- ✅ Ejecución rápida de aplicación ya instalada
- ✅ Selección de puerto interactiva
- ✅ Verificación de entorno virtual
- ✅ Detección de conflictos de puerto

### 3. **install_and_run.ps1** (PowerShell)
**Versión avanzada con parámetros**

```powershell
# Ejecución básica
PowerShell -ExecutionPolicy Bypass -File install_and_run.ps1

# Con puerto específico
PowerShell -ExecutionPolicy Bypass -File install_and_run.ps1 -Port 8502

# Instalación forzada (sobrescribir)
PowerShell -ExecutionPolicy Bypass -File install_and_run.ps1 -Force

# Sin verificación de puerto
PowerShell -ExecutionPolicy Bypass -File install_and_run.ps1 -SkipPortCheck
```

**Características:**
- ✅ Parámetros de línea de comandos
- ✅ Detección automática de puertos disponibles
- ✅ Manejo avanzado de errores
- ✅ Colores y formato mejorado

### 4. **quick_install.bat**
**Instalación rápida de una línea**

```cmd
# Puerto por defecto (8501)
quick_install.bat

# Puerto personalizado
quick_install.bat 8502
```

**Características:**
- ✅ Instalación mínima y rápida
- ✅ Una sola línea de comando
- ✅ Ideal para usuarios avanzados

## 🔌 Configuración de Puertos

### **Puertos Recomendados:**
- **8501** - Puerto por defecto de Streamlit
- **8502, 8503, 8504** - Puertos alternativos
- **3000, 3001** - Puertos de desarrollo web
- **5000, 5001** - Puertos Flask alternativos

### **Puertos Especiales:**
- **80** - HTTP estándar (requiere permisos de administrador)
- **443** - HTTPS estándar (requiere permisos de administrador)
- **8080** - Proxy web común

### **Verificar Puerto Ocupado:**
```cmd
netstat -an | find ":8501"
```

## 🛠️ Solución de Problemas

### **Error: "Python no se reconoce"**
```cmd
# Verificar instalación
python --version

# Si falla, reinstalar Python con "Add to PATH"
```

### **Error: "Git no se reconoce"**
```cmd
# Verificar instalación
git --version

# Instalar desde: https://git-scm.com/download/win
```

### **Error: "Puerto en uso"**
```cmd
# Encontrar proceso usando el puerto
netstat -ano | find ":8501"

# Terminar proceso (reemplazar PID)
taskkill /PID 1234 /F

# O usar puerto alternativo
install_and_run.bat
# Luego seleccionar puerto diferente
```

### **Error: "No se puede ejecutar scripts PowerShell"**
```powershell
# Cambiar política de ejecución temporalmente
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# O ejecutar directamente
PowerShell -ExecutionPolicy Bypass -File install_and_run.ps1
```

### **Error: "Streamlit no se instala"**
```cmd
# Activar entorno virtual manualmente
cd chat-IA
venv\Scripts\activate.bat

# Instalar manualmente
pip install --upgrade pip
pip install streamlit

# Ejecutar
streamlit run app.py
```

## 🎯 Casos de Uso

### **Instalación Primera Vez:**
```cmd
install_and_run.bat
```

### **Ejecución Diaria:**
```cmd
cd chat-IA
run.bat
```

### **Instalación Rápida para Desarrolladores:**
```cmd
quick_install.bat 8502
```

### **Instalación con PowerShell (Avanzado):**
```powershell
PowerShell -ExecutionPolicy Bypass -File install_and_run.ps1 -Port 8502 -Force
```

### **Servidor en Puerto 80 (Administrador):**
1. Abrir CMD como Administrador
2. Ejecutar:
```cmd
install_and_run.bat
# Seleccionar puerto 80 cuando pregunte
```

## 📊 Comparación de Scripts

| Script | Facilidad | Características | Uso Recomendado |
|--------|-----------|----------------|------------------|
| **install_and_run.bat** | ⭐⭐⭐⭐⭐ | Completo, visual | Primera instalación |
| **run.bat** | ⭐⭐⭐⭐ | Ejecución rápida | Uso diario |
| **install_and_run.ps1** | ⭐⭐⭐ | Avanzado, parámetros | Usuarios técnicos |
| **quick_install.bat** | ⭐⭐ | Mínimo, rápido | Desarrolladores |

## 🔧 Personalización

### **Cambiar Puerto por Defecto:**
Editar el script y cambiar:
```bat
set "DEFAULT_PORT=8501"
```
Por:
```bat
set "DEFAULT_PORT=8502"
```

### **Agregar Modelos Adicionales:**
Editar `.env` después de la instalación:
```env
# Agregar nuevas API keys
NUEVO_MODELO_API_KEY=tu_api_key_aqui
```

### **Configurar Proxy:**
Si estás detrás de un proxy corporativo:
```cmd
set HTTP_PROXY=http://proxy.empresa.com:8080
set HTTPS_PROXY=http://proxy.empresa.com:8080
install_and_run.bat
```

## 📞 Soporte

Si tienes problemas con los scripts:

1. **Verifica requisitos:** Python 3.8+, Git
2. **Ejecuta como administrador** si usas puertos < 1024
3. **Revisa conexión a internet** para clonar repositorio
4. **Abre issue en GitHub** con detalles del error

---

**¡Disfruta de la instalación automática!** 🎉
