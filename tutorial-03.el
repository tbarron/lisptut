;; Emacs Lisp Tutorial 03: Functions
;;
;; In this file, we'll write our first Emacs Lisp function. Here it is:

(defun hello ()
  "Greet the world"
  (message "Hello, world!"))

;; When you evaluate the expression above, you should see "hello" in
;; the minibuffer. That's Lisp acknowledging that you have given it a
;; function definition for the symbol "hello". To run the function,
;; evaluate the expression below.

(hello)

;; A function definition consists of
;;
;;  - the word "defun", followed by
;;  - the name of the function, followed by
;;  - a list naming the arguments the function expects, followed by
;;  - an optional (but strongly recommended) string describing the
;;    function, followed by
;;  - the body of the function (with an implicit progn around it)
;;
;; Notice that the whole thing is enclosed in a pair of parens.
;;
;; Earlier, we used <execute-extended-command> to run a function.
;; Let's try that with hello.

(execute-extended-command nil 'hello)

;; This puts us into the debugger with the message "‘hello’ is not a
;; valid command name". But we just defined it. Or defuned it.
;; Whatever. Why isn't Lisp running it?
;;
;; Well, there's another bit of the defun syntax that I haven't told
;; you about. Right after the description string, you can optionally
;; include an expression to make the function interactive so
;; execute-extended-command can see it. Try this:

(defun hear-me ()
  "Test interactive"
  (interactive)
  (message "Can you hear me now?"))

;; and then evaluate hear-me

(hear-me)

;; Some functions should be callable with <execute-extended-command>
;; while others should perhaps not be exposed to direct user
;; invocation. The (interactive) form gives you control over this
;; aspect of your functions. Without (interactive), functions can
;; still be bound to key sequences and called from other functions,
;; they just aren't visible to <execute-extended-command>.
