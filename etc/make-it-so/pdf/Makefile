# This is a template for the Makefile.
# Parameters should go in the upper half as:
#     width = 200
# and be referenced in the command as $(width)

#______________________________________________________________________________


DIRPDF = $(shell dir *.pdf)

DIROUT.PDF = $(DIRPDF:.pdf=.out.pdf)

all: clean Makefile $(DIROUT.PDF)

%.out.pdf: %.pdf
	echo "add command here"
	echo $@ >> provide

clean:
	rm -f *.out.pdf provide

# Insert the install command here.
# e.g. sudo apt-get install ffmpeg
install-tools:
	echo "No tools required"

.PHONY: all install-tools clean