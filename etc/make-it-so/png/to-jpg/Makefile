# -- Commentary ---------------------------------------------------------------
# Convert JPGs to PNGs with imagemagick

# Image quality
quality = 100

# -----------------------------------------------------------------------------

DIRPNG = $(shell dir *.png)

DIRJPG = $(DIRPNG:.png=.jpg)

all: clean Makefile $(DIRJPG)

%.jpg: %.png
	convert -quality $(quality) "$^" "$@"
	echo $@ >> provide

clean:
	rm -f *.jpg provide

install-tools:
	sudo apt-get install imagemagick

.PHONY: all install-tools clean
