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
;;  - a list naming the arguments the function expects enclosed in
;;    parentheses, followed by
;;  - an optional (but strongly recommended) string describing the
;;    function, followed by
;;  - the body of the function (with an implicit <progn> around it)
;;
;; Notice that the whole thing is enclosed in a pair of parens, making
;; it a Lisp s-expression.
;;
;; As you saw above, you can run the function by evaluating the
;; "(hello)" form (i.e., typing C-xC-e with the cursor positioned
;; after the last paren)
;;
;; Now try running <hello> with execute-extended-command. That is,
;; type M-x, then type 'hello' in response to the M-x prompt and press
;; ENTER.
;;
;; You should see "[No match]" appear in the message area after the
;; 'hello' that you typed. You can type C-g to cancel the command
;; prompt and return to the buffer.
;;
;; So M-x didn't work. What else can we try? Well, M-x calls
;; <execute-extended-command>, which always prompts for the name of
;; the function or command to run. To run a function or command from
;; inside Lisp, we can pass it to <command-execute>. Below, you'll
;; find a form set up to do that. Try evaluating it now.

(command-execute 'hello)

;; This generates the error message
;;
;;     Wrong type argument: commandp, hello
;;
;; in the message area. What does that mean?
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

(command-execute 'hear-me)

;; Some functions should be callable with <execute-extended-command>
;; (or <command-execute>, depending on the context) while others
;; should perhaps not be exposed to direct user invocation. The
;; (interactive) form gives you control over this aspect of your
;; functions. Without (interactive), functions can still be bound to
;; key sequences and called from other functions, they just aren't
;; visible to <execute-extended-command>.
;;
;; == Arithmetic ==
;;
;; In Lisp, arithmetic uses prefix notation. Where other programming
;; languages say "2 + 2", Lisp says "(+ 2 2)". Try evaluating an
;; arithmetic expression wrapped in a message so we can see the
;; result:

(message "%d" (+ 2 2))

;; Putting functions and arithmetic together, we can write functions
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
;; adding 1 to the beginning of the list ("cons 1 fibo-list", which
;; returns a list consisting of its second argument -- normally a list
;; -- with its first argument stuck on the front of it).
;;
;; Here we see a case of an if statement with some else forms. If the
;; length test fails because the list has two or more elements, we
;; evaluate all the forms in the body of the if after the second
;; (remember the first form in an if is the test and the second is the
;; "true" option).
;;
;; You might notice something odd about this list. We add the next
;; value, not at the end of the list, but at the beginning. The reason
;; for this is that it's much easier to add and remove items at the
;; front of a list rather at the tail. When we display it, it's easy
;; to reverse the list first to put it in the order we normally expect
;; to see it in.
;;
;; == Local Variables ==
;;
;; You might notice that we named the variable holding the list in
;; fibo10 "fibo-list". That was to associate it with the function
;; since we just let it get created in the global symbol space where
;; all the other Lisp symbols live. Can we make local variables in a
;; function that disappear when the function stops running? Yes! Let's
;; rewrite fibo10 to show how this is done.

(defun fibo10 ()
  "Compute and report the first ten elements of the fibonacci sequence"
  (interactive)
  (let ((fibo-list ()))
    (while (< (length fibo-list) 10)
      (if (< (length fibo-list) 2)
          (setq fibo-list (cons 1 fibo-list))
        (setq fibo-list (cons
                         (+ (car fibo-list)
                            (car (cdr fibo-list))) fibo-list))
        (message "%S" (reverse fibo-list))
        (sleep-for 1.0)))
    (message "all done")))

;; The let form uses its first argument to set variables, then
;; evaluates the rest of its arguments with those newly bound
;; variables in place. Essentially, we wrapped the entire body of the
;; function in the let form. When control leaves the let form, the
;; variables defined by its first argument go out of scope and
;; disappear, which is just what we want a local variable to do.

(fibo10)

;; == With an argument ==
;;
;; What if we want to generate some number of fibonacci sequence
;; values other than 10? We want a function called fibo that accepts
;; an argument and generates that many sequence values. Here's how
;; that could work

(defun fibo (howmany)
  "Compute and report the first X elements of the fibonacci sequence"
  (interactive)
  (let ((ll ()))
    (while (< (length ll) howmany)
      (if (< (length ll) 2)
          (setq ll (cons 1 ll))
        (setq ll (cons (+ (car ll) (car (cdr ll))) ll))
        (message "%S" (reverse ll))
        (sleep-for 1.0)))
    (message "all done")))

(fibo 7)

(fibo 13)

;; == Using recursion ==
;;
;; Recursion is a common techinque in lisp. This is where we have a
;; function call itself. We can write fibo in terms of recursion

(defun fibo (howmany)
  "Compute the first <howmany> items of the fibonacci sequence"
  (interactive)
  (let (ll)
    (if (<= howmany 1)
        (list 1)
      (if (<= howmany 2)
          (cons 1 (fibo (- howmany 1)))
        (setq ll (fibo (- howmany 1)))
        (cons (+ (car ll) (car (cdr ll))) ll)))))

(message "%s" (fibo 6))

;; In this case, we've pulled the "message" call to display the result
;; outside the fibo function so it's only called once, after all the
;; work is done.

;; Now let's write a function that actually operates on Emacs buffers.
;; Often I want to cycle through all the buffers I'm working on
;; (without having to hit all the system buffers like "*Messages*"
;; along the way). Here's our start:

(defun buffer-lru ()
  "Jump to the least recently used non-system buffer"
  (interactive)
  (let ((bl (buffer-list)))
    (while (< 0 (length bl))
      ...)))

;; The funnction buffer-list will return the list of currently active
;; buffers (including the system ones) in the order visited with least
;; recently used last.

;; function buffer-lru -- go to the least recently used buffer

(defun buffer-lru ()
  "Jump to the least recently used non-system buffer"
  (interactive)
  (let ((bl (buffer-list))
        buf
        bname
        lastbuf)
    (while (< 0 (length bl))
      ; take the first buffer in the list
      (setq buf (car bl))
      (setq bname (buffer-name buf))

      ; drop leading whitespace
      (while (string= (substring bname 0 1) " ")
        (setq bname (substring bname 1 nil)))

      ; skip system buffers (whose name begins with "*")
      (if (not (string= (substring bname 0 1) "*"))
          ; record the last seen user buffer
          (setq lastbuf buf))

      ; drop the first buffer from the list
      (setq bl (cdr bl)))

    ; switch to the last user buffer seen in the list
    (switch-to-buffer lastbuf)))


(debug-on-entry 'buffer-lru)
(cancel-debug-on-entry 'buffer-lru)
(global-set-key "\C-x\C-l" 'buffer-lru)
(buffer-lru)
(buffer-list)

;; using emacs lisp for scripting

;; how can a function manipulate its argument list? So, for example,
;; I'd like to write a function called flash that does a message and
;; then sleeps for a second.

;; How do functions return values? How and when should one use the
;; return function?
