;; Emacs Lisp Tutorial 01: Introduction
;;
;; This file is the beginning of a tutorial for Emacs Lisp. To work
;; through the tutorial, load it into Emacs and start reading.
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
;; University of Chicago tutorial (the first one in the list above)
;; down to "Files, Buffers and Windows" before continuing. It will
;; explain the keystroke notation used here.
;;
;; If you're interested in Emacs Lisp, you may also be interested in
;; the tutorial for ELisp that comes with Emacs. To access it, do
;; <info> (usually M-h i) and select "Emacs Lisp Intro" from the menu.
;; That tutorial leans toward providing context and, in doing so,
;; sometimes makes it difficult for me to find what I'm looking for.
;; This tutorial aims to be a bit more direct and practical, providing
;; useful Lisp-oriented information as early as possible.
;;
;; We'll also use the notation "<FUNCTION-NAME>" to mean "do whatever
;; you have to to run function FUNCTION-NAME." That might be hitting a
;; keystroke sequence you have already bound to the function or
;; running execute-extended-command (normally bound to M-x) and
;; typing the name of the function. That is,
;; <execute-extended-command> (usually hitting Escape then X) will
;; open a prompt and let you type the name of a function you want to
;; run.
;;
;; Of course, you can edit the contents of these files and I hope you
;; will hack on the examples to try out ideas that occur to you.
;;
;; With this file open in Emacs, you can run the Lisp forms by
;; positioning the cursor after the final parenthesis and firing
;; <eval-last-sexp>. Doing this is called "evaluating the form" or
;; "evaluating the expression". A Lisp form is a string in parentheses
;; like the "Hello world" line below.

(message "Hello, world!")

;; Here's one way to evaluate the "Hello, world" form:
;;
;;  - position the cursor after the ")" at the end of the line
;;  - type M-x "eval-last-sexp".
;;
;; The result should be "Hello, world!" displayed in the minibuffer
;; (the message line at the bottom of your window).
;;
;; If you haven't monkeyed with your key bindings, you may find that
;; <eval-last-sexp> is already (or still) bound to C-xC-e. If so, you
;; can skip the next few paragraphs about rebinding the key sequence.
;;
;; Typing "eval-last-sexp" every time we want to run something is
;; going to get tiresome pretty quickly. We can bind the function to a
;; keystroke sequence to make the process easier. Evaluate the
;; following form (i.e., position after the last paren and
;; <eval-last-sexp> again). After that, you'll be able to
;; <eval-last-sexp> by just typing the C-xC-e keystroke sequence.

(global-set-key "\C-x\C-e" 'eval-last-sexp)

;; Of course, if you already have eval-last-sexp bound to some other
;; keystroke sequence, or you'd prefer something other than C-xC-e,
;; you can use that.
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
;; as your code is running to identify and correct problems. If you've
;; used the printf() function in C, this will look fairly familiar.
;;
;; Here's another form to evaluate. It will start the debugger with
;; the error message "Format specifier doesn't match argument type".
;; Just hit "q" to return here from the debugger.

(message "%d" "foo")

;; We told message to expect an integer (%d) but then we gave it a
;; string ("foo"). As a result, message is telling us, "Those don't
;; match up. Try again." Generally the %s specifier will take any
;; argument and convert it to string representation if it has to. The
;; integer specifiers (%d, %x, %o, etc.) require numeric arguments.
;;
;; You can learn more about the message function by reading Emacs'
;; help page about it. To access documentation for message, evaluate
;; this:

(describe-function 'message)

;; The way message works is by calling the function "format" to
;; process the format string and arguments, then writing the result in
;; the minibuffer. You can get more details about the various format
;; specifiers (%s, %d, etc.) by reading the help info for format:

(describe-function 'format)

;; The %S specifier prints any Lisp object as an s-expression
;; ("symbolic expression"). This may be useful for deducing what is
;; happening when code gets confusing.

(message "%S" (list 1 2 3))

;; Now check out your buffer list, <electric-buffer-list> (I use C-x
;; C-b). Notice the buffer named "*Messages*". If you open it (just
;; position the cursor on it and hit RET), you'll see all the messages
;; that we've generated so far. Sometimes it's hard to see what's
;; going on with just the minibuffer, especially if you need to report
;; several pieces of information in a row, since the minibuffer can
;; only show one message at a time. The *Messages* buffer shows the
;; message history so you can see all the messages that have been
;; produced since Emacs started.
;;
;; In this file, we've started learning how to communicate with Emacs
;; Lisp, to get it to do our bidding and report back to us about
;; what's going on using the <message> function. We've also learned
;; how to bind keystroke sequences to Emacs commands and how to ask
;; Emacs for information about its functions.
;;
;; To continue the tutorial, open tutorial-02.el. If all the tutorial
;; files are available in the current directory, evaluating the
;; following form will do it.

(find-file "tutorial-02.el")
