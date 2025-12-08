# clean-app

This is a small Flask application that I containerized using Docker and deployed to Kubernetes with Helm.  
I built this project to practice basic DevOps concepts like containers, Kubernetes objects, Helm templating, and simple application configuration.

The app includes a few endpoints just for testing and understanding how environment variables, probes, and Secrets work inside a cluster.

---

## Project Structure

flask-helm-k8s/
├─ app/
│  └─ app.py
├─ charts/
│  └─ flask-app/
│     ├─ Chart.yaml
│     ├─ values.yaml
│     ├─ values-dev.yaml
│     ├─ values-prod.yaml
│     └─ templates/
│        ├─ _helpers.tpl
│        ├─ deployment.yaml
│        ├─ service.yaml
│        ├─ ingress.yaml
│        ├─ configmap.yaml
│        ├─ secret.yaml
│        └─ hpa.yaml
├─ Dockerfile
├─ Makefile
├─ requirements.txt
└─ .gitignore

---

## Application Endpoints

- `/hello` – simple test route  
- `/health` – used for Kubernetes liveness/readiness probes  
- `/config` – shows config values from a ConfigMap  
- `/secret` – checks if a Secret is available  

The default port is **5000**.

---

## Running Locally

python3 app.py

or using Docker:

make docker-build
make docker-run

---

## Helm Deployment

### Install (dev example)

make helm-install


### Update release

make helm-upgrade


### Remove release

make helm-uninstall


The Helm chart contains:

- Deployment  
- Service  
- Ingress  
- ConfigMap  
- Secret  
- HorizontalPodAutoscaler (enabled in production values)  

---

## Configuration

The app reads environment variables using:

- **ConfigMap** → general application settings  
- **Secret** → sensitive values  
- `values.yaml`, `values-dev.yaml`, `values-prod.yaml` → environment overrides  

Examples of values used:

APP_ENV
APP_PORT
APP_SECRET


