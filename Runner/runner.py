from judo.runner.base_runner import BaseRunner
import os

# Habilitar modo debug para el reporter de Judo
os.environ['JUDO_DEBUG_REPORTER'] = 'false'


class MyRunner(BaseRunner):
    """Runner personalizado de Judo Framework con configuración específica del proyecto"""
    
    def __init__(self):
        super().__init__(
            features_dir="../features",                      # Ubicación de features relativa a Runner/
            output_dir="./judo_reports",                     # Directorio de reportes HTML
            
            generate_cucumber_json=True,                    # Deshabilitar generación de JSON Cucumber
            cucumber_json_dir="./judo_reports/cucumber-json",
            
            parallel=False,                                  # Ejecución secuencial
            max_workers=6,                                   # Workers para modo paralelo (si se habilita)
            
            save_requests_responses=False,                    # Guardar logs de request/response de API
            requests_responses_dir="./judo_reports/api_logs" # Directorio de logs de API
        )

    def run_tests(self, tags=None):
        """Ejecuta tests con los tags especificados o todos si no se proveen tags"""
        tags = tags or ["@mix"]
        return self.run(tags=tags)


if __name__ == "__main__":
    # Establecer directorio de trabajo en carpeta Runner/
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    
    runner = MyRunner()
    print("🥋 Judo Framework - Ejecutando desde Runner/")
    print(f"📁 Features dir: {os.path.abspath('../features')}")
    print(f"📊 Reports dir: {os.path.abspath('./judo_reports')}")
    
    try:
        results = runner.run_tests()
        print(f"📊 Resultado: {results['passed']}/{results['total']} tests pasaron")
        if results['total'] > 0:
            print(f"📄 Ver reporte HTML en: Runner/judo_reports/test_execution_report.html")
    except Exception as e:
        print(f"❌ Error durante la ejecución: {e}")