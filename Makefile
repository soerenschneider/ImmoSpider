.PHONY: venv

run:
	podman run -v scrappy:/output -e URL="${URL}" immo

run-native:
	venv/bin/scrapy crawl immoscout -o apartments.csv -a url="${URL}" -L INFO

venv:
	python3 -m venv venv
	venv/bin/pip3 install -r requirements.txt

docker:
	podman build -t immo .
