Emacs configuration.

Oriented around vim-style keybindings and PHP programming... for the
moment.

Warning: If you want a good easy Emacs starter pack, please go look at
Emacs Prelude[1] or similar.  I've used Emacs in some form for more
than five years (not counting my long torrid affair with Vim) and thus
am not afraid to totally remap things and enable "scary" disabled
commands[2] and the like.  This is really more for my own personal
use.

Do feel free to steal from it though.

# Installation

If you already have a .emacs.d folder, move that out of the way and
do not throw it away in case you don't want to use my stuff.

Clone the repo into your home directory.  On *nix this should be
obvious.  On Windows you can find it through Win+R and search for
%appdata%.

Copy site-init.example.el to site-init.el and hack it up to your
needs.

Start up Emacs and pray that something isn't broken.  If it is, fix
it.  Ain't the bleeding edge fun?

# Keybindings

Key | Does:
--- | -----
,f  | Find files
,b  | Find buffers (open files)
,j  | Swap back to previous buffer
,k  | Kill buffer
,g  | Magit
,e  | Prefix key for miscellaneous things (Helm)

# Customizing

I have different needs between work and home (different paths,
different packages); so I've built in the ability to customize the
setup.

Stick any require calls or other customization in site-init.el (that
you should have copied from site-init.example.el).  If you want to
install a package off MELPA, use use-package; look at the lisp/config
files for how to use this.  If you want some package that isn't on
MELPA, stick it in lisp/ (it should be gitignored, except for the
use-package, jws, and config packages) and have at it.

[1] https://github.com/bbatsov/prelude
[2] http://www.emacswiki.org/emacs/DisabledCommands
