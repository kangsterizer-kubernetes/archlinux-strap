RELDATE    := $(shell date +'%Y.%m.01')
RELEASE    := archlinux-bootstrap-$(RELDATE)-x86_64.tar.gz
URI        := https://mirrors.kernel.org/archlinux/iso/latest/$(RELEASE)
PGPGURI    := $(URI).sig
TRUSTEDKEY := 4AA4767BBC9C4B1D18AE28B77F2D434B9741E8AC
CACHE      :=  --no-cache

all: download verify unpack build

build: Dockerfile
	@echo Building archlinux version: $(RELDATE)
	docker build $(CACHE) -t archlinux:latest .

unpack: archroot
archroot:
	mkdir archroot && tar -C archroot -xzpf $(RELEASE)

verify: $(RELEASE).sig
$(RELEASE).sig:
	curl -# -L -O $(URI).sig
	gpg --recv-key $(TRUSTEDKEY)
	gpg --verify $(RELEASE).sig

download: $(RELEASE)
$(RELEASE):
	curl -# -L -O $(URI)

hub:
	docker login
	docker tag archlinux:latest kangsterizer/archlinux-strap
	docker push kangsterizer/archlinux-strap

clean:
	rm $(RELEASE) $(RELEASE).sig
	rm -rf archroot
	rm Dockerfile

.PHONY: build clean all
