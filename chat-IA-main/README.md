# 🤖 Chat IA - Aplicación de Chat con Modelos LLM Gratuitos

Una aplicación de chat moderna y segura que utiliza modelos LLM gratuitos de OpenRouter a través de una interfaz web intuitiva construida con **Streamlit**.

## 🚀 Características Principales

### 🔒 **Seguridad Total**
- ✅ API keys preconfiguradas y seguras
- ✅ Sin exposición de credenciales en el frontend
- ✅ Variables de entorno protegidas

### 🤖 **Modelos LLM Incluidos**
- **Qwen 2.5 VL 72B** (131,072 tokens) - Modelo avanzado de visión-lenguaje
- **Gemma 3 27B** (131,072 tokens) - Modelo de Google optimizado para instrucciones  
- **DeepSeek R1 Zero** (163,840 tokens) - Modelo de razonamiento matemático

### 🎨 **Interfaz Moderna con Streamlit**
- ✅ Chat en tiempo real con historial
- ✅ Selección fácil de modelos
- ✅ Configuración avanzada de parámetros
- ✅ Estadísticas de chat en tiempo real
- ✅ Exportación de conversaciones en JSON
- ✅ Diseño responsive para móvil y desktop

### ⚙️ **Configuración Avanzada**
- 🌡️ Control de temperatura (creatividad)
- 📏 Límite de tokens configurable
- 🎯 Top-P para diversidad de respuestas
- ⏰ Timestamps en cada mensaje

## 📋 Requisitos del Sistema

- **Windows 11** (recomendado)
- **Python 3.8 o superior**
- **Visual Studio Code** (recomendado)
- **Git** (para clonar el repositorio)
- **Conexión a Internet** (para acceder a los modelos)

## 🛠️ Instalación Paso a Paso en Windows 11

### **PASO 1: Instalar Python**

1. **Descargar Python:**
   - Ve a [python.org](https://www.python.org/downloads/)
   - Descarga Python 3.11 o superior
   - **IMPORTANTE**: Durante la instalación, marca "Add Python to PATH"

2. **Verificar instalación:**
   ```cmd
   python --version
   pip --version
   ```

### **PASO 2: Instalar Git**

1. **Descargar Git:**
   - Ve a [git-scm.com](https://git-scm.com/download/win)
   - Descarga e instala Git para Windows

2. **Verificar instalación:**
   ```cmd
   git --version
   ```

### **PASO 3: Instalar Visual Studio Code**

1. **Descargar VS Code:**
   - Ve a [code.visualstudio.com](https://code.visualstudio.com/)
   - Descarga e instala VS Code

2. **Instalar extensiones recomendadas:**
   - Python (Microsoft)
   - Python Debugger (Microsoft)
   - Pylance (Microsoft)

### **PASO 4: Clonar el Repositorio**

1. **Abrir Terminal en VS Code:**
   - Presiona `Ctrl + Shift + `` (backtick)
   - O ve a Terminal → New Terminal

2. **Clonar el proyecto:**
   ```bash
   # 1. Clonar el repositorio
   git clone https://github.com/Cesde-Suroeste/chat-IA.git
   cd chat-IA
   ```

### **PASO 5: Configurar Entorno Virtual**

```bash
# 2. Crear entorno virtual
python -m venv venv

# 3. Activar entorno virtual (Windows)
venv\Scripts\activate
```

**Nota:** Deberías ver `(venv)` al inicio de tu línea de comandos

### **PASO 6: Instalar Dependencias**

```bash
# 4. Instalar dependencias
pip install -r requirements.txt
```

### **PASO 7: Ejecutar la Aplicación**

```bash
# 5. Ejecutar aplicación
streamlit run app.py
```

### **PASO 8: Abrir en el Navegador**

- La aplicación se abrirá automáticamente en `http://localhost:8501`
- Si no se abre automáticamente, copia la URL desde la terminal

## 🎮 Cómo Usar la Aplicación

### **Interfaz Principal**

1. **Barra Lateral Izquierda:**
   - **Selección de Modelo**: Dropdown con todos los modelos disponibles
   - **Configuración Avanzada**: Sliders para temperatura, max tokens, y top-p
   - **Estado de API**: Indicador "✅ API Key Configured"
   - **Limpiar Chat**: Botón para reiniciar la conversación

2. **Área Central:**
   - **Chat Interface**: Conversación en tiempo real
   - **Campo de Entrada**: Escribe tu mensaje aquí
   - **Timestamps**: Marca de tiempo en cada mensaje

3. **Panel Derecho:**
   - **Estadísticas**: Contadores de mensajes
   - **Información del Modelo**: Detalles del modelo actual
   - **Exportación**: Descarga conversaciones en JSON

### **Uso Básico**

1. **Seleccionar Modelo:**
   - En la barra lateral, elige entre Qwen, Gemma, o DeepSeek

2. **Ajustar Parámetros (Opcional):**
   - **Temperature**: 0.0 (preciso) a 2.0 (creativo)
   - **Max Tokens**: Longitud máxima de respuesta
   - **Top P**: Diversidad de respuestas

3. **Chatear:**
   - Escribe tu mensaje en el campo inferior
   - Presiona Enter o haz clic en enviar
   - ¡Disfruta de la conversación!

## 🔧 Solución de Problemas

### **Error: "Python no se reconoce"**
- Reinstala Python marcando "Add to PATH"
- Reinicia VS Code y la terminal

### **Error: "streamlit no se reconoce"**
- Verifica que el entorno virtual esté activado
- Ejecuta: `pip install streamlit`

### **Error: "Port 8501 is already in use"**
- Usa otro puerto: `streamlit run app.py --server.port 8502`

### **Error: "No API key configured"**
- Verifica que el archivo `.env` existe en el directorio raíz
- Las API keys ya están configuradas, no necesitas cambiar nada

### **La aplicación no responde**
- Verifica tu conexión a internet
- Comprueba que OpenRouter esté disponible
- Revisa la consola de VS Code para errores

## 📊 Modelos Configurados

| Modelo | Context Window | Descripción | Uso Recomendado |
|--------|---------------|-------------|-----------------|
| **Qwen 2.5 VL 72B** | 131,072 tokens | Modelo avanzado de visión-lenguaje | Conversaciones generales, análisis de texto |
| **Gemma 3 27B** | 131,072 tokens | Modelo de Google optimizado | Instrucciones específicas, programación |
| **DeepSeek R1 Zero** | 163,840 tokens | Modelo de razonamiento | Matemáticas, problemas lógicos |

## 🚀 Ventajas de Streamlit

- ✅ **Desarrollo Rápido**: Interfaz completa en Python
- ✅ **Reactivo**: Actualizaciones automáticas de la UI
- ✅ **Componentes Ricos**: Chat, sliders, métricas integradas
- ✅ **Fácil Despliegue**: Compatible con múltiples plataformas
- ✅ **Sin JavaScript**: Todo en Python, más fácil de mantener

## 📝 Comandos Útiles

```bash
# Activar entorno virtual
venv\Scripts\activate

# Instalar dependencias
pip install -r requirements.txt

# Ejecutar aplicación
streamlit run app.py

# Ejecutar en puerto específico
streamlit run app.py --server.port 8502

# Desactivar entorno virtual
deactivate
```

## 🤝 Contribuciones

Las contribuciones son bienvenidas:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/nueva-caracteristica`)
3. Commit tus cambios (`git commit -m 'Agregar nueva característica'`)
4. Push a la rama (`git push origin feature/nueva-caracteristica`)
5. Abre un Pull Request

## 📞 Soporte

Si tienes problemas:

1. **Revisa esta documentación**
2. **Verifica los requisitos del sistema**
3. **Abre un issue en GitHub** con detalles del error
4. **Incluye la versión de Python y sistema operativo**

## 📄 Licencia

MIT License - ver archivo [LICENSE](LICENSE) para detalles.

---

**¡Disfruta chateando con IA de forma segura y gratuita!** 🎉
