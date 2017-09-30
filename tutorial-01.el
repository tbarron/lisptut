;; This file is a tutorial for Emacs Lisp.
;;
;; You can run Lisp forms in it by highlighting a line and invoking
;; the function eval-region. A Lisp form is a string in parentheses
;; like the "Hello world" line below.
;;
;; Try it now. Select and run the "Hello, world" form below. That is,
;;
;;  - type Escape Space at the beginning of the "Hello, world" line,
;;  - navigate to the end of the line (\C-e),
;;  - and type Escape, X, "eval-region".
;;
;; The result should be "Hello, world!" displayed in the message line
;; at the bottom of your window.

(message "Hello, world!")

;; Typing "eval-region" every time we want to run something is not
;; convenient. We can bind it to a keystroke to make it easier. Select
;; the next line and run it. After that, you'll be able to run
;; eval-region by just typing Escape r

(global-set-key "\M-r" 'eval-region)

;; In the line above, "\M-r" tells Lisp that we want to bind the
;; function eval-region to the keystroke sequence Escape, r. Later in
;; this tutorial, we'll use this syntax to denote keystroke sequences.
;; The string "\C-t" means Control-t. That is, hold the Control button
;; while pressing the t key.
;;
;; The process of selecting a form and running eval-region on it is
;; called "evaluating" the form. From now on, when I want you to
;; select some lines and call eval-region, I'll just say something
;; like, "Evaluate the following form." That means that you should
;; select all the lines of the form, including both the beginning and
;; ending parentheses and then hit \M-r.
;;
;; The message function is very powerful. Let's look it at some more.
;; It will let us see what's going on with our code. Evaluate the form
;; below and we'll talk about what it does

(message "%s %s %s %s %d" "now" "is" "the" "time" 13)

;; You should have seen "now is the time 13" in your message line. The
;; first argument to message (the first string after the word
;; "message") is the FORMAT string. It contains items like %s and %d.
;; %s means format a subsequent argument as a string. %d means format
;; a subsequent argument as an integer. This will let you display the
;; contents of variables and the results of calculations as your code
;; is running to identify and correct problems.
;;
;; Here's another form to evaluate

(message "%d" "foo")

;; The expected result in the message line is "Format specifier
;; doesn’t match argument type". This is an error message. We told
;; message to expect an integer (%d) but then we gave it a string
;; ("foo"). As a result, message is telling us, "Those don't match up.
;; Try again, dude."





