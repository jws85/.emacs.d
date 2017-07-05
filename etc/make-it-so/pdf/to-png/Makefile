# -- Commentary ---------------------------------------------------------------
# Convert PDFs to single-page PNGs using imagemagick
#
# The output page numbers will be the basename of the original PDF, with a
# -NNNNN.png added.  The NNNNN is the page number, starting from 00000.

# You will probably need to add this if your PDF is text-based rather than
# image-based; otherwise your PDF will have a transparent background.
nontransparent = -alpha remove -background white

# The DPI.  72 is consumer-scanner quality.  300 is professional-level quality.
density = 100

# Image quality
quality = 100

# -----------------------------------------------------------------------------

DIRPDF = $(shell dir *.pdf)

# This rule name is a lie -- since there can be multiple PNGs, the output
# filename contains page numbers.
DIRPNG = $(DIRPDF:.pdf=.png)

all: clean Makefile $(DIRPNG)

%.png: %.pdf
	convert -density $(density) -quality $(quality) "$^" "$(basename $^)-%05d.png"
	ls "$(basename $^)"-*.png >> provide

clean:
	rm -f *.png provide

install-tools:
	sudo apt-get install imagemagick

.PHONY: all install-tools clean
