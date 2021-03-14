all:
	emacs --batch -l org config.org -f org-babel-tangle

clean:
	rm -f early-init.el init.el *\~

cleanpackages:
	rm -rf straight

veryclean: clean cleanpackages
	rm -f  places recentf smex-items *\~
	rm -rf auto-save-list
