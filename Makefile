OCITOOL=docker # or docker
BUILDDIR=$(shell pwd)/build
OUTPUTDIR=$(shell pwd)/output

.PHONY: clean
clean:
	rm -rf $(BUILDDIR) $(OUTPUTDIR)

.PRECIOUS: $(OUTPUTDIR)/%.tar.zst
$(OUTPUTDIR)/%.tar.zst:
	scripts/make-rootfs.sh $(*) $(BUILDDIR) $(OUTPUTDIR)

.PRECIOUS: $(OUTPUTDIR)/Dockerfile.%
$(OUTPUTDIR)/Dockerfile.%: $(OUTPUTDIR)/%.tar.zst
	scripts/make-dockerfile.sh "$(*).tar.zst" $(*) $(OUTPUTDIR) "true" "Dev"

# The following is for local builds only, it is not used by the CI/CD pipeline

all: image-base image-base-devel image-multilib-devel
image-%: $(OUTPUTDIR)/Dockerfile.%
	${OCITOOL} build -f $(OUTPUTDIR)/Dockerfile.$(*) -t archlinux/archlinux:$(*) $(OUTPUTDIR)


.PHONY: build
build:
	docker build -t arch-wsl .

extract:
	make build
	docker create --name arch-wsl arch-wsl
	docker export arch-wsl -o arch-wsl.tar
	gzip arch-wsl.tar
	docker rm arch-wsl
	docker rmi arch-wsl
