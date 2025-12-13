from judo.runner.base_runner import BaseRunner
import os
import os
os.environ['JUDO_DEBUG_REPORTER'] = 'true'

class MyRunner(BaseRunner):

    def __init__(self):
        # Ajustar rutas a tu estructura
        super().__init__(
            features_dir="../features",  # Subir un nivel y entrar a features
            output_dir="./judo_reports",  # Reportes en Runner/judo_reports

            generate_cucumber_json=False,
            cucumber_json_dir="./judo_reports/cucumber-json",

            parallel=False,
            max_workers=6,

            save_requests_responses=True,  # 🆕 Habilitar logging
            requests_responses_dir="./judo_reports/api_logs"
        )

    def run_smoke_tests(self):
        features = self.find_features(tags=["@headers"])
        print(f"📁 Archivos encontrados con @headers:")
        for f in features:
            print(f"  - {f}")

        return self.run(tags=["@headers"])

    def run_api_tests_parallel(self):
        self.set_parallel(True, max_workers=8)
        return self.run(tags=["@api"], exclude_tags=["@manual"])


# Uso
if __name__ == "__main__":
    # Cambiar al directorio correcto
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    runner = MyRunner()

    print("🥋 Judo Framework - Ejecutando desde Runner/")
    print(f"📁 features dir: {os.path.abspath('../features')}")
    print(f"📊 Reports dir: {os.path.abspath('./judo_reports')}")

    try:
        results = runner.run_smoke_tests()
        print(f"📊 Resultado: {results['passed']}/{results['total']} tests pasaron")

        if results['total'] > 0:
            print(f"📄 Ver reporte HTML en: Runner/judo_reports/")

    except Exception as e:
        print(f"❌ Error: {e}")
        print("💡 Verifica que el archivo features/feature1.feature tenga tags @test1")
