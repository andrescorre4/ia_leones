# 🔑 Configuración de API Keys

Este documento explica cómo configurar las API keys para usar la aplicación Chat IA.

## 🚀 Obtener API Keys Gratuitas

### **Paso 1: Crear cuenta en OpenRouter**
1. Ve a [OpenRouter.ai](https://openrouter.ai)
2. Crea una cuenta gratuita
3. Verifica tu email

### **Paso 2: Obtener API Keys**
1. Ve a [OpenRouter Keys](https://openrouter.ai/keys)
2. Haz clic en "Create Key"
3. Dale un nombre descriptivo (ej: "Chat-IA-Qwen")
4. Copia la API key generada

### **Paso 3: Configurar Variables de Entorno**

1. **Copia el archivo de ejemplo:**
   ```bash
   cp .env.example .env
   ```

2. **Edita el archivo .env:**
   ```bash
   # En Windows con VS Code
   code .env
   
   # En Linux/Mac
   nano .env
   ```

3. **Reemplaza los valores de ejemplo:**
   ```env
   # Antes (ejemplo)
   QWEN_API_KEY=sk-or-v1-tu_api_key_para_qwen_aqui
   
   # Después (tu API key real)
   QWEN_API_KEY=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
   ```

## 🤖 Modelos Disponibles

### **Modelos Gratuitos Recomendados:**

| Modelo | ID | Descripción |
|--------|----|-----------| 
| **Qwen 2.5 VL 72B** | `qwen/qwen2.5-vl-72b-instruct:free` | Modelo avanzado de visión-lenguaje |
| **Gemma 3 27B** | `google/gemma-3-27b-it:free` | Modelo de Google optimizado |
| **DeepSeek R1 Zero** | `deepseek/deepseek-r1-zero:free` | Modelo de razonamiento |

### **Otros Modelos Gratuitos:**
- `meta-llama/llama-3.2-3b-instruct:free`
- `microsoft/phi-3-mini-128k-instruct:free`
- `google/gemma-2-9b-it:free`
- `qwen/qwen-2-7b-instruct:free`

## 🔧 Configuración Avanzada

### **Opción 1: Una API Key para Todos los Modelos**
```env
QWEN_API_KEY=tu_api_key_aqui
GEMMA_API_KEY=tu_api_key_aqui
DEEPSEEK_API_KEY=tu_api_key_aqui
DEFAULT_API_KEY=tu_api_key_aqui
```

### **Opción 2: API Keys Separadas por Modelo**
```env
QWEN_API_KEY=tu_api_key_para_qwen
GEMMA_API_KEY=tu_api_key_para_gemma
DEEPSEEK_API_KEY=tu_api_key_para_deepseek
DEFAULT_API_KEY=tu_api_key_por_defecto
```

## 🔒 Seguridad

### **✅ Buenas Prácticas:**
- ✅ Nunca subas el archivo `.env` a GitHub
- ✅ Usa API keys diferentes para proyectos diferentes
- ✅ Revoca API keys que no uses
- ✅ Mantén tus API keys privadas

### **❌ Evita:**
- ❌ Compartir API keys en chat o email
- ❌ Hardcodear API keys en el código
- ❌ Usar la misma API key para todo
- ❌ Subir credenciales a repositorios públicos

## 🆘 Solución de Problemas

### **Error: "No API key configured"**
1. Verifica que el archivo `.env` existe
2. Verifica que las API keys están correctas
3. Reinicia la aplicación Streamlit

### **Error: "API Error 401"**
1. Verifica que la API key es válida
2. Verifica que no ha expirado
3. Verifica que tienes créditos disponibles

### **Error: "API Error 429"**
1. Has excedido el límite de requests
2. Espera unos minutos antes de intentar de nuevo
3. Considera usar una API key diferente

## 📞 Soporte

Si tienes problemas con las API keys:

1. **Revisa la documentación de OpenRouter:** [docs.openrouter.ai](https://docs.openrouter.ai)
2. **Verifica tu cuenta:** [openrouter.ai/activity](https://openrouter.ai/activity)
3. **Abre un issue en GitHub** con detalles del error (sin incluir tu API key)

---

**¡Mantén tus API keys seguras!** 🔐
