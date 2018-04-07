Emacs configuration.

Oriented around vim-style keybindings and PHP programming... for the
moment.

Warning: If you want a good easy Emacs starter pack, please go look at
Emacs Prelude[1] or Spacemacs[2] or similar.  I've run this code in
various states of breakage, and anticipate more breakage in the future.
That said, I try to sorta-test before pushing here.

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

NOTE:  I used to run bleeding-edge Emacs from the git repository,
but now I think I'm going to try to keep up with the latest numbered
version.  As of 2018-04-06, that is 25.3.  That said, I caused some
breakage by going backwards :P

NOTE:  This is so oriented around vim keybindings that you may need
to install evil through M-x package-list-packages before anything
else will auto-install...

NOTE:  If you're changing Emacs versions, especially if you're going
backwards (e.g. trying out a development build, then going back to
stable), you may need to blow away the elpa/ directory to get rid of
.elc files built against the newer version.

# Keybindings

The keybindings section is probably forever doomed to be super out
of date.  A while back, I re-oriented myself to work more like
Spacemacs, so almost everything that isn't some kind of Evil binding
is hanging off the Space key.

If you're in a mode where Space doesn't work, M-j should do the same
thing.

Specifically, SPC f should open a file switcher and SPC b should
open a buffer switcher.  I'm not even sure I can guarantee those
staying the same in the future...

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
[2] http://spacemacs.org/
[3] http://www.emacswiki.org/emacs/DisabledCommands
