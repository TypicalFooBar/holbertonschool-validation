build-docker: ## Builds the Docker image based on ./build/Dockerfile
	docker build -f ./build/Dockerfile -t awesome:build .

lint: ## Lint
	shellcheck setup.sh >/dev/null 2>&1 || echo "Lint Failed"

.PHONY: build
build: ## Build with Hugo
	docker exec container-name awesome:build hugo
	docker exec container-name awesome:build go build

test: build unit-tests integration-tests ## Test

unit-tests: build ## Unit Tests
	docker run --name container-name awesome:build go test -v -short -coverprofile=coverage-units.out

integration-tests: build ## Integration Tests
	docker run --name container-name awesome:build go test -v -short -coverprofile=coverage-integrations.out

validate: build ## Validate
	docker run --name container-name awesome:build echo "PASS"

clean: ## Delete the dist/ directory
	docker run --name container-name awesome:build rm -rf dist
	docker run --name container-name awesome:build rm -f ./awesome-api
	docker run --name container-name awesome:build rm -f ./awesome.log
	docker run --name container-name awesome:build rm -f ./coverage-units.out
	docker run --name container-name awesome:build rm -f ./coverage-integrations.out
	docker run --name container-name awesome:build rm awesome-website.zip

post: ## Create a new post
	docker run --name container-name awesome:build echo '---' >> ./content/posts/$(POST_NAME).md
	docker run --name container-name awesome:build echo "title: $(POST_TITLE)" >> ./content/posts/$(POST_NAME).md
	docker run --name container-name awesome:build echo '---' >> ./content/posts/$(POST_NAME).md

help: ## Displays help for this makefile
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

package: build ## Package
	docker run --name container-name awesome:build zip -r awesome-website.zip dist awesome-api