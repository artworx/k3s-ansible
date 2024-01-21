.PHONY: check-install upload download compare replace

OS := $(shell uname)
S3_BUCKET := s3://homelab
INVENTORY_FILE := inventory.yml

all: check-install

check-install:
ifeq ($(OS),Darwin)
	@which s3cmd || brew install s3cmd
else ifeq ($(OS),Linux)
	@which s3cmd || sudo apt-get install s3cmd
else
	$(error Unsupported operating system)
endif

push: check-install
	s3cmd sync $(INVENTORY_FILE) $(S3_BUCKET)/$(INVENTORY_FILE)

pull: check-install
	s3cmd sync $(S3_BUCKET)/$(INVENTORY_FILE) $(INVENTORY_FILE)
