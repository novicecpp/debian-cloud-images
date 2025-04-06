# path to the config space shoud be absolute, see fai.conf(5)

DESTDIR = .

help:
	@echo "To run this makefile, run:"
	@echo "   make image_<DIST>_<CLOUD>_<ARCH>"
	@echo "  WHERE <DIST> is bullseye, bookworm, trixie, sid"
	@echo "    And <CLOUD> is azure, ec2, gce, generic, genericcloud, nocloud"
	@echo "    And <ARCH> is amd64, arm64, ppc64el"
	@echo "Set DESTDIR= to write images to given directory."

image_%:
	umask 022; \
	./bin/debian-cloud-images build \
	  $(subst _, ,$*) \
	  --build-id manual \
	  --version $(shell date '+%Y%m%d%H%M') \
	  --localdebs \
	  --output $(DESTDIR) \
	  --override-name $@

usual: image_bookworm_generic_amd64

clean:
	rm -rf image_*.*
