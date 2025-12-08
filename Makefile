APP_NAME=clean-app
IMAGE=clean:latest
NAMESPACE=default
CHART=./charts/clean-app

run:
  python3 app.py

docker-build:
    docker build -t $(IMAGE) .

docker-run:
    docker run -p 5000:5000 $(IMAGE)

docker-push:
	docker push $(IMAGE)

helm-install:
	helm install $(APP_NAME) $(CHART) -n $(NAMESPACE)

helm-upgrade:
	helm upgrade $(APP_NAME) $(CHART) -n $(NAMESPACE)

helm-uninstall
	helm uninstall $(APP_NAME) -n $(NAMESPACE)

test:
	pytest -v

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +