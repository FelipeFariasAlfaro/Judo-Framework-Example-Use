from judo.runner.base_runner import BaseRunner

class MyRunner(BaseRunner):
    def run_tests(self, tags=None):
        tags = tags or ["@mix_ejecutar_todo"]
        return self.run(tags=tags)

if __name__ == "__main__":
    runner = MyRunner()
    results = runner.run_tests()


