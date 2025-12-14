#!/usr/bin/env python3
"""
🥋 Judo Framework - Runner Personalizado para Demostración

Este runner está configurado específicamente para demostrar todas las capacidades
de Judo Framework. Incluye configuración optimizada para reportes, logging y
organización de resultados.

Para probar diferentes casos, modifica el TAG @ en la funcion run_tests()

Autor: Felipe Farias A.
Fecha: 2025
https://www.centy.cl
"""

from judo.runner.base_runner import BaseRunner
import os
import sys
from pathlib import Path

# ============================================
# CONFIGURACIÓN DE DEBUG Y LOGGING
# ============================================

# Controla el nivel de debug del reporter de Judo
# 'true' = Muestra información detallada de debug
# 'false' = Solo muestra información esencial
os.environ['JUDO_DEBUG_REPORTER'] = 'false'

# Opcional: Configurar nivel de logging adicional
# os.environ['JUDO_LOG_LEVEL'] = 'INFO'


class MyRunner(BaseRunner):
    """
    Runner personalizado que extiende BaseRunner de Judo Framework.
    
    Esta clase configura todos los aspectos necesarios para ejecutar
    los tests de demostración con la configuración óptima.
    """

    basedir = "./judo_reports"

    def __init__(self):
        """
        Inicializa el runner con configuración personalizada.
        
        Configuraciones principales:
        - Rutas de archivos y directorios
        - Generación de reportes
        - Logging de peticiones/respuestas
        - Configuración de paralelización
        """
        super().__init__(
            # ============================================
            # CONFIGURACIÓN DE DIRECTORIOS
            # ============================================
            
            # Directorio donde están los archivos .feature
            # "../features" = subir un nivel desde Runner/ y entrar a features/
            features_dir="../features",
            
            # Directorio donde se guardarán todos los reportes
            # "./judo_reports" = crear carpeta judo_reports dentro de Runner/
            output_dir=self.basedir,

            # ============================================
            # CONFIGURACIÓN DE REPORTES
            # ============================================
            
            # Generar reportes en formato JSON cucumber (compatible con CI/CD)
            # Útil para integración con XRAY, Jenkins, GitHub Actions, etc.
            generate_cucumber_json=True,
            
            # Directorio específico para reportes JSON
            cucumber_json_dir=f"{self.basedir}/cucumber-json",

            # ============================================
            # CONFIGURACIÓN DE EJECUCIÓN
            # ============================================
            
            # Ejecución en paralelo
            # False = Ejecutar tests secuencialmente (más estable para demo)
            # True = Ejecutar tests en paralelo (más rápido)
            parallel=False,
            
            # Número máximo de workers para ejecución paralela
            # Solo se usa si parallel=True
            max_workers=2,

            # ============================================
            # CONFIGURACIÓN DE LOGGING DE API
            # ============================================
            
            # Guardar todas las peticiones y respuestas HTTP
            # Extremadamente útil para debugging y auditoría
            save_requests_responses=True,
            
            # Directorio donde se guardan los logs de API
            # Cada escenario tendrá su propia carpeta con:
            # - Request completo (headers, body, URL)
            # - Response completo (status, headers, body)
            requests_responses_dir=f"{self.basedir}/api_logs"
        )

    def run_tests(self):
        """
        Ejecuta todos los tests de demostración en inglés.
        Utiliza el tag @eng_examples_all que incluye todos los ejemplos
        en inglés del archivo all_examples.feature.
        """
        return self.run(tags=["@mix"])
    


def print_banner():
    """Imprime un banner informativo al inicio."""
    print("=" * 60)
    print("🥋 JUDO FRAMEWORK - PROYECTO DE DEMOSTRACIÓN")

def print_report_locations():
    """Imprime las ubicaciones de los reportes generados."""
    print("\n📄 REPORTES GENERADOS:")
    print("-" * 30)
    
    # Verificar si existen los directorios de reportes
    reports_dir = Path("./judo_reports")
    
    if reports_dir.exists():
        html_report = reports_dir / "test_execution_report.html"
        if html_report.exists():
            print(f"🌐 Reporte HTML: {html_report.absolute()}")
        
        json_dir = reports_dir / "cucumber-json"
        if json_dir.exists():
            print(f"📋 Reportes JSON: {json_dir.absolute()}")
        
        api_logs_dir = reports_dir / "api_logs"
        if api_logs_dir.exists():
            print(f"🔍 Logs de API: {api_logs_dir.absolute()}")
    
    print("-" * 30)


# ============================================
# EJECUCIÓN PRINCIPAL
# ============================================

if __name__ == "__main__":
    """
    Punto de entrada principal del runner.
    Este bloque se ejecuta cuando se llama directamente al script:
    python runner.py
    """
    
    # Cambiar al directorio correcto para ejecución
    # Esto asegura que las rutas relativas funcionen correctamente
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)
    
    # Mostrar banner informativo
    print_banner()
    
    # Mostrar información de configuración
    print(f"📁 Directorio de features: {os.path.abspath('../features')}")
    print(f"📊 Directorio de reportes: {os.path.abspath('./judo_reports')}")
    print(f"🐍 Python version: {sys.version.split()[0]}")
    
    try:
        # Crear instancia del runner
        runner = MyRunner()
        
        print("\nIniciando ejecución de tests...")
        
        # Ejecutar tests principales (inglés)
        results = runner.run_tests()

        # Mostrar ubicaciones de reportes
        print_report_locations()

    
    except KeyboardInterrupt:
        print("\n\n⏹Ejecución interrumpida por el usuario")
        sys.exit(1)
    
    except Exception as e:
        print(f"\n❌ Error durante la ejecución: {e}")
        print("\n🔧 POSIBLES SOLUCIONES:")
        print("   1. Ejecuta 'python ../debug_judo.py' para diagnóstico")
        print("   2. Verifica que Judo Framework esté instalado: 'pip install judo-framework'")
        print("   3. Verifica la estructura de archivos .feature")
        print("   4. Revisa la conectividad de red")
        sys.exit(1)
