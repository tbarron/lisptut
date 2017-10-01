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
;; == Interactive functions ==
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
;;
;; == Arithmetic ==
;;
;; In Lisp, arithmetic uses prefix notation. Where other programming
;; languages say "2 + 2", Lisp says "(+ 2 2)". Try evaluating an
;; arithmetic expression wrapped in a message so we can see the
;; result:

(message "%d" (+ 2 2))

;; Putting functions and arithmetic together, we can write a function
;; to compute mathematical structures. For example, the first ten
;; values of the Fibonacci sequence:

(defun fibo10 ()
  "Compute and report the first ten elements of the fibonacci sequence"
  (interactive)
  (setq fibo-list ())
  (while (< (length fibo-list) 10)
    (if (< (length fibo-list) 2)
        (setq fibo-list (cons 1 fibo-list))
      (setq fibo-list (cons
                       (+ (car fibo-list)
                          (car (cdr fibo-list))) fibo-list))
      (message "%S" (reverse fibo-list))
      (sleep-for 1.0)))
  (message "all done")
  )

;; Evaluate the defun above, then run it by evaluating the form below.

(fibo10)

;; == Debugging ==
;;
;; We can step through this function in the debugger to see exactly
;; what is happening in sequence. Here are some of the most commonly
;; used debugger commands:
;;
;;    c: continue -- let the function run to completion
;;    d: step -- stop on the next form to be evaluated
;;    h: help -- get a list of debugger commands
;;    q: quit -- exit the debugger and return to previous context
;;
;; To set up the debugger to run when fibo10 is called, evaluate the
;; following:

(debug-on-entry 'fibo10)

;; To cancel debug-on-entry so fibo10 can be run without the debugger
;; again, evaluate this:

(cancel-debug-on-entry 'fibo10)

;; In this example, we see several new wrinkles. We're building a list
;; called fibo-list, so we use a while loop to repeatedly add items to
;; the list. However, the first two items in the list should just be 1
;; while subsequent items are computed by summing the two most
;; recently added values. So we have an if form that lets us tell
;; whether we're adding the first two 1's or a later value. We check
;; whether the length of the list is less than 2. If so, we're just
;; adding 1 to the list ("cons 1 fibo-list").
;;
;; Here we see a case of an if statement with some else forms. If the
;; length test fails because the list has two or more elements, we
;; evaluate all the forms in the body of the if after the second
;; (remember the first form in an if is the test and the second is the
;; "true" option).
;;
;; You might notice something odd about this list. We add the next
;; value, not at the end of the list, but at the beginning.
;;
;; == Keeping variables local ==
;;
;; You might notice that we named the variable holding the list in
;; fibo10 "fibo-list" to associate it with the function since we just
;; let it get created in the global symbol space where all the other
;; Lisp symbols live.
;;
;; == Using recursion ==
