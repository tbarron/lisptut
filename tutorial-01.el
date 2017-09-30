;; This file is a tutorial for Emacs Lisp. To work through the
;; tutorial, load it into Emacs and start reading.
;;
;; This tutorial assumes some basic familiarity with Emacs itself and
;; focuses on the Lisp language built into the Emacs engine. If you
;; are brand new to Emacs, you'll probably get more out of some of the
;; tutorials that introduce Emacs itself like the following:
;;
;;   http://www2.lib.uchicago.edu/keith/tcl-course/emacs-tutorial.html
;;
;;   http://www.jesshamrick.com/2012/09/10/absolute-beginners-guide-to-emacs/
;;
;;   http://www.tuxradar.com/content/emacs-tutorial-beginners
;;
;;   https://masteringemacs.org/article/beginners-guide-to-emacs
;;
;;   http://ergoemacs.org/emacs/emacs.html
;;
;; In this tutorial, we'll use notation like "M-r" to mean "hit
;; Escape, then the r key". If this is unfamiliar, go read the
;; University of Chicago tutorial down to "Files, Buffers and Windows"
;; before continuing. It will explain the keystroke notation used
;; here.
;;
;; We'll also use the notation "<FUNCTION-NAME>" to mean "do whatever
;; you have to to run function FUNCTION-NAME." That might be hitting a
;; keystroke sequence you have bound to the function or running
;; execute-extended-command (I have it bound to M-x) and typing the
;; name of the function. That is, <execute-extended-command> will open
;; a prompt and let you type the name of a function to run.
;;
;; You can run Lisp forms in this file by selecting the form and doing
;; <eval-region>. Doing this is called "evaluating the form". A Lisp
;; form is a string in parentheses like the "Hello world" line below.
;;
;; Here's one way to evaluate the "Hello, world" form below:
;;
;;  - <set-mark> at the beginning of the "Hello, world" line (I would
;;    type M-space to <set-mark>),
;;  - navigate to the end of the line (C-e),
;;  - and type M-x "eval-region".
;;
;; The result should be "Hello, world!" displayed in the message line
;; at the bottom of your window.

(message "Hello, world!")

;; Typing "eval-region" every time we want to run something is not
;; convenient. We can bind eval-region to a keystroke to make this
;; process easier. Evaluate the following form (i.e., select it and
;; <eval-region> again). After that, you'll be able to run eval-region
;; by just typing Escape r

(global-set-key "\M-r" 'eval-region)

;; Of course, if you already have eval-region bound to some other
;; keystroke sequence, you can just use that.
;;
;; The message function is very powerful. Let's look it at it a little
;; more closely. It will let us see what's going on with our code.
;; Evaluate the form below and we'll talk about what it does

(message "%s %s %s %s %d" "now" "is" "the" "time" 13)

;; Evaluating this should put "now is the time 13" in your message
;; line. The first argument to message (the first string after the
;; word "message") is the FORMAT string. It contains items like %s and
;; %d. %s means format a subsequent argument as a string. %d means
;; format a subsequent argument as an integer. This will let you
;; display the contents of variables and the results of calculations
;; as your code is running to identify and correct problems.
;;
;; Here's another form to evaluate

(message "%d" "foo")

;; The expected result in the message line is "Format specifier
;; doesn’t match argument type". This is an error message. We told
;; message to expect an integer (%d) but then we gave it a string
;; ("foo"). As a result, message is telling us, "Those don't match up.
;; Try again, dude."





