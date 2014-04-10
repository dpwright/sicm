; Exercise 1.2
; Translate the expression into prefix form
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))

; Exercise 1.3
; Define a procedure that takes three numbers as arguments and returns the sum
; of the squares of the two larger numbers.
(define (ex1.3 x y z)
  (define (square x) (* x x))
  (define (max x y) (if (> x y) x y))
  (define (sum-of-squares x y) (+ (square x) (square y)))
  (if (> x y)
    (+ (sum-of-squares x (max y z)))
    (+ (sum-of-squares y (max x z)))))

; Exercise 1.4
; Describe the behaviour of the following procedure:
    (define (a-plus-abs-b a b)
      ((if (> b 0) + -) a b))
; This will add b to a if b is positive, otherwise it will subtract it.
; In other words it adds the absolute value of b to a.

; Exercise 1.5
; Given the procedures:
    (define (p) (p))
    (define (test x y)
      (if (= x 0)
        0
        y))
; What would be the result of running: (test 0 (p))?
; The answer is of course an infinite loop as it will attempt to evaluate the
; value of (p) before calling the function (test) which discards it.  This is in
; contrast to what would happen under normal-order (lazy) evaluation, in which
; case the computation in the else branch of the if statement would never be run
; and so (test 0 (p)) would simply return 0.

; Exercise 1.6
; What would happen if we attempted to use the following implementation to
; compute square roots?
    (define (new-if predicate then-clause else-clause)
      (cond (predicate then-clause)
            (else else-clause)))
    (define (sqrt-iter guess x)
      (new-if (good-enough? guess x)
              guess
              (sqrt-iter (improve guess x)
                         x)))
; The answer is an infinite loop, for the same reasons as outlined above.

; Exercise 1.7
; Design a square-root procedure that stops when the change is a very small
; fraction of the guess, rather than when the square of the guess is a small
; number away from the required result.
(define (sqrt x)
  (define (good-enough? guess last-guess)
    (< (/ (abs (- guess last-guess))
          guess)
       0.001))

  (define (average x y)
    (/ (+ x y) 2))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (sqrt-iter guess last-guess x)
    (if (good-enough? guess last-guess)
      guess
      (sqrt-iter (improve guess x)
                 guess
                 x)))

  (sqrt-iter (improve 1.0 x) 1.0 x))

; Exercise 1.8
; Implement a cube-root procedure analogous to the square-root procedure.
(define (cbrt x)
  (define (good-enough? guess last-guess)
    (< (/ (abs (- guess last-guess))
          guess)
       0.001))

  (define (improve guess x)
    (/ (+ (/ x (square guess)) (* 2 guess))
       3))

  (define (cbrt-iter guess last-guess x)
    (if (good-enough? guess last-guess)
      guess
      (cbrt-iter (improve guess x)
                 guess
                 x)))

  (cbrt-iter (improve 1.0 x) 1.0 x))
