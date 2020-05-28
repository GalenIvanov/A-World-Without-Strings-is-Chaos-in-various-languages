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

; 8 - esreveR A ecnetneS
; Given a string x consisting of words (one or more non-space characters)
; which are separated by spaces, reverse the order of the characters in each word.

(define (f8 str)
  (string-join (map (λ (x)(list->string (reverse (string->list x))))
                    (string-split str))))

; 9 - Compression Session
; Given a string x and a boolean vector y of the same length,
; extract the characters of x corresponding to a 1 in y.

(define (f9 str mask)
  (list->string (map (λ (x)(string-ref str x))
                     (indexes-of mask 1))))

; 10 - Expansion Mansion
; Given a string x and a boolean vector y, spread the characters of x
; to the positions of 1s in y, filling intervening characters with underscores.

(define (f10 str mask)
  (local ((define (spread str mask acc)
            (cond
              [(empty? mask) (list->string (reverse acc))]
              [(= 1 (first mask)) (spread (rest str) (rest mask) (cons (first str) acc))]
              [else (spread str (rest mask) (cons #\_ acc))])))
    (spread (string->list str) mask '())))

; 11 - C_ns_n_nts
; Given a string x, replace all the vowels (a, e, i, o, u, or y) with underscores.

(define (f11 str [alos '("a" "o" "e" "i" "u" "y" "A" "O" "E" "I" "U" "Y")])
  (if (empty? alos)
      str
      (f11 (string-replace str (first alos) "_") (rest alos))))

; 12 - Cnsnnts Rdx
; Given a string x, remove all the vowels entirely.

(define (f12 str)
  (list->string (filter (λ (x) (not (member x (string->list "aoeiuyAEUY"))))
                        (string->list str))))

; 13 - TITLE REDACTED
; Given a string x consisting of words separated by spaces (as above),
; and a string y, replace all words in x which are the same as y with a series of xes.

(define (f13 str word)
  (string-replace str word (build-string (string-length word) (λ (_) #\X))))
  
; 14 - It’s More Fun to Permute
; Given a string x, generate a list of all possible reorderings of the characters in x.

(define (f14 str)
  (local ((define (permute lst)
            (cond
              [(empty? lst) empty]
              [(empty? (rest lst)) (list lst)]
              [else
               (let split ([l '()][m (first lst)][r (rest lst)])
                 (append
                  (map (λ (x) (cons m x)) (permute (append l r)))
                  (if (empty? r) empty
                      (split (append l (list m)) (first r) (rest r)))))])))
    (map list->string (permute (string->list str)))))


; +-------+
; | Tests |
; +-------+

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

(map f8 '("a few words in a sentence" "zoop" "one two three four"))

(f9 "foobar" '(1 0 0 1 0 1))
(f9 "embiggener" '(0 0 1 1 1 1 0 0 1 1))

(f10 "fbr" '(1 0 0 1 0 1))
(f10 "bigger" '(0 0 1 1 1 1 0 0 1 1))

(map f11 '("FLAPJACKS" "Several normal words"))

(map f12 '("Several normal words" "FLAPJACKS"))

(f13 "a few words in a sentence" "words")
(f13 "one fish two fish" "fish")
(f13 "I don't give a care" "care")
