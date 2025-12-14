

from behave import given
import time

@given(u'go to url "{url}"')
def step_impl(context, url):
    print(f"🌐 Navegando a: {url}")
    context.judo_context.page.goto(url, timeout=30000)
    time.sleep(10)