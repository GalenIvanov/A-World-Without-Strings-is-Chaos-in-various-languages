#lang racket

; 0 - Multiplicity
; Given a string x and a character y, how many times does y occur in x?
(define (f0 str char)
  (count (λ (x)(char=? char x)) (string->list str)))

; 1 - Trapeze Part
; Given a string x, is it identical when read forwards and backwards?
(define (f1 str)
  (string=? str (list->string (reverse (string->list str)))))


; 2 - Duplicity
; Given a string x, produce a list of characters which appear more than once in x.
(define (f2 str)
  (let ([l-str (string->list str)])
    (filter (λ(u)(> (count (λ(y)(char=? u y)) l-str) 1))
            (remove-duplicates l-str))))

; 3 - Sort Yourself Out
; Given strings x and y, do both strings contain the same letters, possibly in a different order?
(define (f3 s1 s2)
  (equal? (sort (string->list s1) char<?)
          (sort (string->list s2) char<?)))

; 4 - Precious Snowflakes
; Given a string x, find all the characters which occur exactly once, in the order they appear.
(define (f4 str)
  (let ([l-str (string->list str)])
    (filter (λ(u)(= (count (λ(y)(char=? u y)) l-str) 1))
            (remove-duplicates l-str))))


; Tests
(f0 "fhqwhgads" #\h)
(f0 "mississippi" #\s)
(f0 "life" #\.)

(map f1 '("racecar" "wasitaratisaw" "palindrome"))

(map f2 '("applauyse" "foo" "baz"))

(f3 "teapot" "toptea")
(f3 "apple" "elap")
(f3 "listen" "silent")

(map f4 '("somewhat heterogenous" "aaabccddefffgg"))