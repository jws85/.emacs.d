# -- Commentary ---------------------------------------------------------------
# Convert JPGs to PNGs with imagemagick

# Image quality
quality = 100

# -----------------------------------------------------------------------------

DIRJPG = $(shell dir *.jpg)

DIRPNG = $(DIRJPG:.jpg=.png)

all: clean Makefile $(DIRPNG)

%.png: %.jpg
	convert -quality $(quality) "$^" "$@"
	echo $@ >> provide

clean:
	rm -f *.png provide

install-tools:
	sudo apt-get install imagemagick

.PHONY: all install-tools clean
