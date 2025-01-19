.PHONY: test start-test-container stop-test-container

start-test-container: docker-compose.test.yml
	@echo "Start docker container for testing"
	docker-compose -f docker-compose.test.yml up -d
	./wait_for_ready.sh
	
stop-test-container:
	@echo "Stop docker container for testing"
	docker-compose -f docker-compose.test.yml down

test: start-test-container
	@echo "Run tests in docker container"
	docker-compose -f docker-compose.test.yml exec test ./vendor/bin/phpunit ./test
