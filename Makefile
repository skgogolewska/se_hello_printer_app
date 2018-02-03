.PHONY: test

deps:
	pip install -r requirements.txt;
	pip install -r test_requirements.txt
lint:
	flake8 hello_world testów
run:
	python main.py

test:
	PYTHONPATH=. py.test

test smoke:
	curl --fail http://127.0.0.1:5000

docker_build:
	docker build -t $(MY_DOCKER_NAME) .

docker_run: docker_build
	docker run \
	--name $(MY_DOCKER_NAME)-dev \
	-p 5000:5000 \
	-d \
	$(MY_DOCKER_NAME)

USERNAME=skgogolewska
TAG=$(USERNAME)/hello-world-printer

docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;
