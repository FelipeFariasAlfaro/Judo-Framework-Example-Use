from judo.behave import *
from dotenv import load_dotenv
import os
import unicodedata
import re

load_dotenv()

def before_all(context):
    before_all_judo(context)

def _should_use_playwright(scenario):
    """Verifica si Playwright debe activarse para este escenario"""
    playwright_enabled = os.getenv('JUDO_USE_BROWSER', 'false').lower() == 'true'
    has_frontend_tag = any(tag in scenario.tags for tag in ['front', 'test-front'])
    return playwright_enabled and has_frontend_tag

def _setup_playwright(context):
    """Configura Playwright en pantalla completa"""
    from playwright.sync_api import sync_playwright
    from judo.playwright.browser_context import JudoBrowserContext
    
    old_context = context.judo_context
    context.judo_context = JudoBrowserContext(context)
    
    # Copiar variables del contexto anterior
    for attr in ['variables', 'base_url']:
        if hasattr(old_context, attr):
            setattr(context.judo_context, attr, getattr(old_context, attr))
    
    # Iniciar Playwright
    context.judo_context.playwright = sync_playwright().start()
    context.judo_context.browser = context.judo_context.playwright.chromium.launch(
        headless=False,
        args=['--start-maximized']
    )
    context.judo_context.browser_context = context.judo_context.browser.new_context(no_viewport=True)
    context.judo_context.page = context.judo_context.browser_context.new_page()
    print("✅ Playwright configurado en pantalla completa")

def before_scenario(context, scenario):
    before_scenario_judo(context, scenario)
    
    if _should_use_playwright(scenario) and not hasattr(context.judo_context, 'page'):
        try:
            _setup_playwright(context)
        except ImportError:
            raise Exception("❌ Playwright no está instalado. Ejecuta: pip install playwright && playwright install chromium")
        except Exception as e:
            print(f"❌ Error configurando Playwright: {e}")
            raise

def _normalize_screenshot_name(step):
    """Normaliza el nombre del paso para usar como nombre de archivo"""
    step_full_name = f"{step.keyword.strip()}_{step.name}"
    
    # Eliminar tildes
    step_full_name = ''.join(
        c for c in unicodedata.normalize('NFD', step_full_name)
        if unicodedata.category(c) != 'Mn'
    )
    
    # Eliminar caracteres inválidos para Windows: < > : " / \ | ? *
    step_full_name = re.sub(r'[<>:"/\\|?*]', '_', step_full_name)
    step_full_name = step_full_name.replace(' ', '_').replace("'", '').replace('-', '_')
    step_full_name = re.sub(r'_+', '_', step_full_name)
    
    status = "passed" if step.status.name == "passed" else "failed"
    return f"{step_full_name}_{status}"

def _capture_screenshot(context, step):
    """Captura screenshot y lo adjunta al reporte"""
    screenshot_name = _normalize_screenshot_name(step)
    print(f"📸 Capturando screenshot: {screenshot_name}")
    
    try:
        screenshot_path = context.judo_context.take_screenshot(screenshot_name, full_page=True)
    except TypeError:
        screenshot_path = context.judo_context.take_screenshot(screenshot_name)
    
    print(f"✅ Screenshot guardado: {screenshot_path}")
    
    # Adjuntar al reporte HTML
    try:
        from judo.reporting.reporter import get_reporter
        reporter = get_reporter()
        if reporter and reporter.current_step:
            reporter.attach_screenshot(screenshot_path)
            print(f"📋 Screenshot adjuntado al reporte HTML")
    except Exception as e:
        print(f"⚠️ No se pudo adjuntar al reporte: {e}")

def after_step(context, step):
    if hasattr(context.judo_context, 'page') and context.judo_context.page:
        try:
            _capture_screenshot(context, step)
        except Exception as e:
            print(f"⚠️ Error capturando screenshot: {e}")
    
    after_step_judo(context, step)

def after_scenario(context, scenario):
    if hasattr(context.judo_context, 'page') and context.judo_context.page:
        try:
            context.judo_context.page.close()
            context.judo_context.page = None
            print("✅ Página cerrada al final del escenario")
        except Exception as e:
            print(f"⚠️ Error cerrando página: {e}")
    
    after_scenario_judo(context, scenario)

def after_all(context):
    if hasattr(context.judo_context, 'browser') and context.judo_context.browser:
        try:
            for attr in ['browser_context', 'browser', 'playwright']:
                if hasattr(context.judo_context, attr) and getattr(context.judo_context, attr):
                    getattr(context.judo_context, attr).close() if attr != 'playwright' else context.judo_context.playwright.stop()
            print("✅ Recursos de Playwright limpiados")
        except Exception as e:
            print(f"⚠️ Error limpiando Playwright: {e}")
    
    after_all_judo(context)

# Hooks de Judo Framework
before_feature = before_feature_judo
after_feature = after_feature_judo
before_step = before_step_judo
