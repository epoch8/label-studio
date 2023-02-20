# Run Django dev server with Sqlite
run-dev:
	DJANGO_DB=sqlite LOG_DIR=tmp DEBUG=true LOG_LEVEL=DEBUG DJANGO_SETTINGS_MODULE=core.settings.label_studio python label_studio/manage.py runserver

# set REDIS_HOST
run-rq-dev:
	DJANGO_DB=sqlite LOG_DIR=tmp DEBUG=true LOG_LEVEL=DEBUG DJANGO_SETTINGS_MODULE=core.settings.label_studio python label_studio/manage.py rqworker critical high default low

# Run Django dev migrations with Sqlite
migrate-dev:
	DJANGO_DB=sqlite LOG_DIR=tmp DEBUG=true LOG_LEVEL=DEBUG DJANGO_SETTINGS_MODULE=core.settings.label_studio python label_studio/manage.py migrate

# Run Django dev shell environment with Sqlite
shell-dev:
	DJANGO_DB=sqlite LOG_DIR=tmp DEBUG=true LOG_LEVEL=DEBUG DJANGO_SETTINGS_MODULE=core.settings.label_studio python label_studio/manage.py shell_plus

# Install modules
frontend-setup:
	cd label_studio/frontend && npm ci && npm run download:all;

# Fetch DM and LSF
frontend-fetch:
	cd label_studio/frontend && npm run download:all;

# Build frontend continuously on files changes
frontend-watch:
	cd label_studio/frontend && npm start

# Build production-ready optimized bundle
frontend-build:
	cd label_studio/frontend && npm ci && npm run build:production

# Run tests
test:
	cd label_studio && DJANGO_DB=sqlite pytest -v -m "not integration_tests"

IMAGE=ghcr.io/epoch8/label-studio/label-studio
IMAGE_TAG=$(shell git describe --tags --abbrev=0)

build-docker:
	docker build -t ${IMAGE}:${IMAGE_TAG} .

upload-docker:
	docker push ${IMAGE}:${IMAGE_TAG}
