VENV ?= .venv
PY ?= $(VENV)/bin/python
PIP ?= $(VENV)/bin/pip

APP_DIR ?= app
APP_NAME ?= flask-app
CHART ?= charts/flask-app
IMAGE ?= flask:local

.PHONY: venv install run compile test helm-check docker-build ci

venv:
	python3 -m venv $(VENV)

install: venv
	$(PY) -m pip install --upgrade pip
	@if [ -f requirements.txt ]; then \
		$(PIP) install --no-cache-dir -r requirements.txt; \
	else \
		echo "No requirements.txt"; \
	fi
	@if [ -f requirements-dev.txt ]; then \
		$(PIP) install --no-cache-dir -r requirements-dev.txt; \
	fi

run: install
	$(PY) $(APP_DIR)/app.py

compile:
	$(PY) -m compileall $(APP_DIR)

test: install
	@if [ -d tests ]; then \
		$(PY) -m pytest -q; \
	else \
		echo "No tests/ folder, skipping"; \
	fi

helm-check:
	helm lint $(CHART)
	helm template $(APP_NAME) $(CHART) > /dev/null

docker-build:
	docker build -t $(IMAGE) .

ci: install compile test helm-check
