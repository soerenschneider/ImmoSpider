.PHONY: venv

run:
	podman run -v scrappy:/output -e URL="${URL}" immo

venv:
	python3 -m venv venv
	venv/bin/pip3 install -r requirements.txt

docker:
	podman build -t immo .
