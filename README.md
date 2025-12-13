# 🥋 Judo Framework - Proyecto de Demostración

## 📋 Descripción

Este proyecto es una **demostración completa** de las capacidades de **Judo Framework**, un potente framework de testing de APIs basado en BDD (Behavior Driven Development) que utiliza Behave como base.

El proyecto incluye ejemplos prácticos de testing de APIs REST, validaciones avanzadas, manejo de datos, flujos de trabajo complejos y mucho más.

## 🎯 ¿Qué es Judo Framework?

Judo Framework es una herramienta que permite escribir tests de API de manera **declarativa y legible**, usando lenguaje natural (Gherkin) para describir los casos de prueba. Elimina la complejidad de escribir código de testing manual y se enfoca en **qué** probar, no en **cómo** probarlo.

### ✨ Características Principales

- 🌐 **Testing de APIs REST completo** (GET, POST, PUT, PATCH, DELETE)
- ✅ **Validaciones avanzadas** (JSONPath, esquemas, arrays, tipos de datos)
- 🔄 **Flujos de trabajo complejos** (CRUD, autenticación, peticiones encadenadas)
- 📁 **Manejo de archivos** (JSON externos, respuestas guardadas, variables)
- 🌍 **Soporte multiidioma** (inglés y español)
- 📊 **Reportes detallados** (HTML, JSON, logs de API)
- 🔧 **Configuración flexible** y fácil de usar

## 🚀 Inicio Rápido

### 1. **Prerrequisitos**

```bash
# Python 3.7 o superior
python --version

# Pip actualizado
pip install --upgrade pip
```

### 2. **Instalación**

```bash

# Crear entorno virtual (recomendado)
python -m venv venv

# Activar entorno virtual
# En Windows:
venv\Scripts\activate
# En Linux/Mac:
source venv/bin/activate

pip install judo-framework

#opcional, instalar judo y otras librerias
pip install -r requirements.txt


```

> **📝 Nota Importante:** Judo Framework se instala con `pip install judo-framework` (con guión), no `judo_framework` (con guión bajo).

### **📦 Archivos de Requirements Disponibles:**

- **`requirements.txt`** - Dependencias principales + utilidades recomendadas


## 🏃 Ejecutar Tests

### **Opción 1: Usando el Runner Personalizado (Recomendado)**

```bash
# Navegar al directorio Runner
cd Runner

# Ejecutar todos los tests
python runner.py
```

**Ventajas del Runner:**
- ✅ Configuración optimizada
- ✅ Reportes HTML automáticos
- ✅ Logs detallados de API
- ✅ Organización de resultados

### **Opción 2: Usando Behave Directamente**

```bash
# Desde la raíz del proyecto

# Ejecutar todos los tests en inglés
behave features/ --tags=@eng_examples_all

# Ejecutar todos los tests en español
behave features/ --tags=@es_ejecutar_todo

# Ejecutar tests específicos por categoría
behave features/ --tags=@http          # Tests de métodos HTTP
behave features/ --tags=@validation    # Tests de validación
behave features/ --tags=@workflow      # Flujos de trabajo
behave features/ --tags=@files         # Operaciones con archivos

# Ejecutar con formato detallado
behave features/ --tags=@eng_examples_all --format=pretty

# Ejecutar tests específicos
behave features/ --tags=@get_en        # Solo tests GET en inglés
behave features/ --tags=@post          # Solo tests POST
```

### **Opción 3: Tests Específicos**

```bash
# Test de un escenario específico
behave features/all_examples.feature:15  # Línea específica

# Tests con nombre específico
behave features/ --name="GET request"

# Tests excluyendo algunos tags
behave features/ --tags="@eng_examples_all and not @slow"
```

## 📊 Ver Resultados

### **Reportes HTML**
Después de ejecutar con el Runner, abre:
```
Runner/judo_reports/test_execution_report.html
```

### **Logs de API**
Revisa las peticiones y respuestas detalladas en:
```
Runner/judo_reports/api_logs/
```

### **Reportes JSON**
Para integración con CI/CD:
```
Runner/judo_reports/cucumber-json/
```

## 📁 Estructura del Proyecto

```
📦 judo-framework-demo/
├── 📁 features/                    # Tests BDD en Gherkin
│   ├── 📄 all_examples.feature     # Ejemplos completos (inglés)
│   ├── 📄 ejemplos_completos.feature # Ejemplos completos (español)
│   ├── 📄 environment.py           # Configuración de Behave
│   └── 📁 steps/                   # Steps personalizados (si los hay)
├── 📁 Runner/                      # Ejecutor personalizado
│   ├── 📄 runner.py                # Runner principal
│   └── 📁 judo_reports/            # Reportes generados
├── 📁 base_requests/               # Datos JSON de entrada
│   ├── 📄 simple_post.json
│   ├── 📄 simple_schema.json
│   └── 📄 update_post.json
├── 📁 base_responses/              # Respuestas guardadas
├── 📁 base_variables/              # Variables extraídas
├── 📄 debug_judo.py                # Script de diagnóstico
├── 📄 .env                         # Variables de entorno
└── 📄 README.md                    # Este archivo
```

## 🎯 Ejemplos de Casos de Uso

### **1. Test Básico de API**
```gherkin
Scenario: GET request - Retrieve a resource
  When I send a GET request to "/users/1"
  Then the response status should be 200
  And the response should contain "id"
  And the response should contain "name"
```

### **2. Test con Datos JSON**
```gherkin
Scenario: POST request - Create a new resource
  When I send a POST request to "/posts" with JSON
    """
    {
      "title": "Judo Framework Test",
      "body": "Testing POST request",
      "userId": 1
    }
    """
  Then the response status should be 201
  And the response field "title" should equal "Judo Framework Test"
```

### **3. Test con Archivos Externos**
```gherkin
Scenario: POST request using JSON file
  When I POST to "/posts" with JSON file "../base_requests/simple_post.json"
  Then the response status should be 201
  And the response should contain "id"
```

### **4. Flujo de Trabajo Complejo**
```gherkin
Scenario: Complete CRUD workflow
  # CREATE
  When I send a POST request to "/posts" with JSON
    """
    {"title": "New Post", "body": "Content", "userId": 1}
    """
  Then the response status should be 201
  And I extract "$.id" from the response as "postId"
  
  # READ
  When I send a GET request to "/posts/{postId}"
  Then the response status should be 200
  
  # UPDATE
  When I send a PUT request to "/posts/{postId}" with JSON
    """
    {"id": 1, "title": "Updated", "body": "Updated", "userId": 1}
    """
  Then the response status should be 200
  
  # DELETE
  When I send a DELETE request to "/posts/{postId}"
  Then the response status should be 200
```

## 📦 Gestión de Dependencias

### **Requirements Files**

El proyecto incluye tres archivos de requirements para diferentes necesidades:

#### **requirements.txt** (Recomendado)
```bash
pip install -r requirements.txt
```
Incluye:
- ✅ Judo Framework (incluye automáticamente behave, requests, jsonpath-ng, etc.)
- ✅ Python-dotenv para variables de entorno
- ✅ Colorama para colores en terminal
- ✅ Dependencias opcionales comentadas

#### **requirements-minimal.txt** (Básico)
```bash
pip install -r requirements-minimal.txt
```
Incluye solo:
- ✅ Judo Framework (con todas sus dependencias automáticas)
- ✅ Python-dotenv (para archivos .env)

#### **requirements-dev.txt** (Desarrollo)
```bash
pip install -r requirements-dev.txt
```
Incluye todo lo anterior más:
- 🧪 Testing (pytest, coverage)
- 🎨 Formateo (black, isort, flake8)
- 📚 Documentación (sphinx, mkdocs)
- 🔧 Herramientas de desarrollo (pre-commit, tox)

### **Para Contribuidores**
```bash
# Instalar dependencias de desarrollo
pip install -r requirements-dev.txt

# Configurar pre-commit hooks
pre-commit install
```

## 🔧 Configuración

### **Variables de Entorno (.env)**
```bash
# API Configuration
API_BASE_URL=https://jsonplaceholder.typicode.com
API_TOKEN=Bearer your-token-here
TIMEOUT_SECONDS=30

# Debug Configuration
JUDO_DEBUG_REPORTER=false
JUDO_LOG_LEVEL=INFO
```

### **Personalizar el Runner**
Edita `Runner/runner.py` para:
- Cambiar tags de ejecución
- Modificar directorios de salida
- Habilitar/deshabilitar funciones
- Configurar paralelización

## 🎨 Características Demostradas

### **✅ Métodos HTTP**
- GET, POST, PUT, PATCH, DELETE
- Query parameters
- Headers personalizados
- Autenticación Bearer Token

### **✅ Validaciones**
- Códigos de estado HTTP
- Campos de respuesta específicos
- JSONPath para datos anidados
- Validación de tipos de datos
- Arrays y colecciones
- Esquemas JSON

### **✅ Manejo de Datos**
- Variables dinámicas
- Extracción de datos de respuestas
- Archivos JSON externos
- Variables de entorno
- Almacenamiento de respuestas

### **✅ Flujos Avanzados**
- Operaciones CRUD completas
- Autenticación con tokens
- Peticiones encadenadas
- Tests parametrizados
- Manejo de errores

## 🐛 Troubleshooting

### **Problema: "No module named 'judo'"**
```bash
# Solución: Instalar Judo Framework
pip install judo-framework

# Verificar instalación
python debug_judo.py
```

### **Problema: "No steps found"**
```bash
# Verificar environment.py
cat features/environment.py

# Debe contener:
from judo.behave import *
```

### **Problema: "Connection refused"**
```bash
# Verificar conectividad
curl -I https://jsonplaceholder.typicode.com/users/1

# Verificar proxy si es necesario
export HTTP_PROXY=http://proxy:8080
```

### **Problema: Tests no se ejecutan**
```bash
# Verificar estructura
ls -la features/
ls -la Runner/

# Ejecutar diagnóstico completo
python debug_judo.py
```

## 📚 Recursos Adicionales

### **Documentación**
- [Judo Framework Docs](https://judo-framework.readthedocs.io/)
- [Behave Documentation](https://behave.readthedocs.io/)
- [JSONPath Syntax](https://goessner.net/articles/JsonPath/)

### **API de Testing**
Este proyecto usa [JSONPlaceholder](https://jsonplaceholder.typicode.com/) como API de prueba:
- Gratuita y pública
- No requiere autenticación
- Simula operaciones CRUD
- Perfecta para aprendizaje

## 🤝 Contribuir

¿Quieres añadir más ejemplos o mejorar el proyecto?

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Añade tus cambios y tests
4. Commit tus cambios (`git commit -m 'Añadir nueva funcionalidad'`)
5. Push a la rama (`git push origin feature/nueva-funcionalidad`)
6. Abre un Pull Request

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la [MIT License](LICENSE).

## 🙏 Agradecimientos

- **Judo Framework Team** - Centyc.cl y Felipe Farias, Por crear esta excelente herramienta
- **JSONPlaceholder** - Por proporcionar una API gratuita para testing
- **Behave Community** - Por la base sólida de BDD

---

## 🚀 ¡Empieza Ahora!

```bash
# Clona el proyecto
git clone <repository-url>
cd judo-framework-demo

# Instala Judo Framework y Behave
pip install judo-framework
pip install behave

# Ejecuta los tests
cd Runner
python runner.py

# ¡Disfruta explorando Judo Framework! 🥋
```

**¿Tienes preguntas?** 
Ingresa en https://www.centyc.cl/judo-framwork-es