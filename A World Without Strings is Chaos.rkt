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

; 5 - Musical Chars
; Given strings x and y, is x a rotation of the characters in y?
(define (f5 str1 str2 [idx 0])
  (if (= idx (string-length str1)) 
      false
      (if (string=? str1 str2) true
      (f5 str1
          (string-append (substring str2 1)
                         (substring str2 0 1))
          (add1 idx)))))
; 6 - Size Matters
; Given a list of strings x, sort the strings by length, ascending.
(define (f6 alos)
  (sort alos (λ (x y)(< (string-length x) (string-length y)))))

; 7 - Popularity Contest
; Given a string x, identify the character which occurs most frequently.
; If more than one character occurs the same number of times, you may choose arbitrarily.
; Is it harder to find all such characters?
(define (f7 str)
  (let* ([l-str (string->list str)]
        [sorted (sort (map (λ(u)(cons u (count (λ(y)(char=? u y)) l-str)))
                           (remove-duplicates l-str))
                      (λ (x y)(< (cdr x) (cdr y))))])
    (map car (filter (λ (x)(= (cdr (last sorted)) (cdr x))) sorted))))


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

(f5 "foobar" "barfoo")
(f5 "fboaro" "foobar")
(f5 "abcde" "deabc")

(f6  '("books" "apple" "peanut" "aardvark" "melon" "pie"))

(map f7 '("abdbbac" "CCCBBBAA"  "CCCBBBBAA" "Mississippi"))
