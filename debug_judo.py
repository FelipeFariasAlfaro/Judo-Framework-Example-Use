#!/usr/bin/env python3
"""
Script de diagnóstico para Judo Framework
"""


def verificar_instalacion():
    """Verificar que Judo Framework esté instalado correctamente"""
    print("🔍 DIAGNÓSTICO DE JUDO FRAMEWORK")
    print("=" * 50)

    try:
        import judo
        print(f"✅ Judo Framework importado")
        print(f"📦 Versión: {getattr(judo, '__version__', 'No disponible')}")

        # Verificar importaciones específicas
        from judo.behave import setup_judo_context
        print("✅ setup_judo_context importado")

        from judo.behave.context import JudoContext
        print("✅ JudoContext importado")

        from judo.runner.base_runner import BaseRunner
        print("✅ BaseRunner importado")

        return True

    except Exception as e:
        print(f"❌ Error: {e}")
        return False


def test_behave_directo():
    """Probar behave directamente"""
    print("\n🧪 PROBANDO BEHAVE DIRECTAMENTE")
    print("=" * 50)

    import subprocess
    import sys
    import os

    # Cambiar al directorio del proyecto
    project_dir = r"C:\Users\felipefarias\git_legado\PythonProject"

    try:
        os.chdir(project_dir)
        print(f"📁 Directorio actual: {os.getcwd()}")

        # Verificar que existan los archivos
        if os.path.exists("features/feature1.feature"):
            print("✅ feature1.feature encontrado")
        else:
            print("❌ feature1.feature NO encontrado")
            return False

        if os.path.exists("features/environment.py"):
            print("✅ environment.py encontrado")
        else:
            print("❌ environment.py NO encontrado")
            return False

        # Ejecutar behave con verbose para ver errores
        cmd = [sys.executable, "-m", "behave", "features/", "--tags", "@test_en1", "-v", "--no-capture"]
        print(f"🏃 Ejecutando: {' '.join(cmd)}")

        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)

        print("\n📊 STDOUT:")
        print(result.stdout)

        if result.stderr:
            print("\n⚠️ STDERR:")
            print(result.stderr)

        print(f"\n📈 Return code: {result.returncode}")

        return result.returncode == 0

    except Exception as e:
        print(f"❌ Error ejecutando behave: {e}")
        return False


def verificar_archivos():
    """Verificar contenido de archivos"""
    print("\n📄 VERIFICANDO ARCHIVOS")
    print("=" * 50)

    project_dir = r"C:\Users\felipefarias\git_legado\PythonProject"

    # Verificar environment.py
    env_file = os.path.join(project_dir, "features", "environment.py")
    if os.path.exists(env_file):
        print("📄 Contenido de environment.py:")
        with open(env_file, 'r', encoding='utf-8') as f:
            content = f.read()
            print(content)
    else:
        print("❌ environment.py no existe")

    # Verificar feature file
    feature_file = os.path.join(project_dir, "features", "feature1.feature")
    if os.path.exists(feature_file):
        print("\n📄 Contenido de feature1.feature:")
        with open(feature_file, 'r', encoding='utf-8') as f:
            content = f.read()
            print(content)
    else:
        print("❌ feature1.feature no existe")


def main():
    if not verificar_instalacion():
        print("\n❌ Problemas con la instalación de Judo Framework")
        return False

    verificar_archivos()

    if not test_behave_directo():
        print("\n❌ Problemas ejecutando behave")
        return False

    print("\n✅ Todo parece estar funcionando correctamente")
    return True


if __name__ == "__main__":
    success = main()
    exit(0 if success else 1)