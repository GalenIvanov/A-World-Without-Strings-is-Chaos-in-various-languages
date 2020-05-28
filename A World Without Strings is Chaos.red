Red [
    Title: "A World Without Strings is Chaos - solutions in Red"
    Source: http://beyondloom.com/blog/strings.html
    Author: "Galen Ivanov"
]

f0: function [
    {0 - Multiplicity
    Given a string x and a character y, how many times does y occur in x?}
    str [string!]
    chr [char!]
][
    n: 0
    parse str [
        any [
              chr (n: n + 1)
            | skip
        ]
    ]
    n
]

f1: function [
    {1 - Trapeze Part
    Given a string x, is it identical when read forwards and backwards?}
    str [string!]
][
    str = reverse copy str
]

f2: function [
    {2 - Duplicity
    Given a string x, produce a list of characters which appear more than once in x.}
    str [string!]
][
    parse sort str [
        any [
            change [
                copy t skip
                copy many-t any t
            ] (any [many-t/1 ""])
        ]
    ]
    str
]

f3: function [
    {3 - Sort Yourself Out
    Given strings x and y, do both strings contain the same letters, possibly in a different order?}
    x [string!]
    y [string!]
][
    (sort x) = sort y
]

f4: function [
    {4 - Precious Snowflakes
    Given a string x, find all the characters which occur exactly once, in the order they appear.}
    str [string!]
][
    charmap: make map! 256
    
    foreach c str [
        either k: select charmap c [
            charmap/:c: k + 1
        ][
            put charmap c 1
        ]
    ]
    rejoin collect [
        foreach c str [
            if charmap/:c = 1 [keep c]
        ]
    ]
]

f5: function [
    {5 - Musical Chars
    Given strings x and y, is x a rotation of the characters in y?}
    x [string!]
    y [string!]
][
    loop length? x [
        if x = y [return true]
        move x tail x
    ]
    false
]

f6: function [
    {6 - Size Matters
    Given a list of strings x, sort the strings by length, ascending.}
    strings [block!]
][
   ; the sort is not stable (/stable doesn't cure the problem)
    sort/compare strings func[a b][(length? a) > length? b]
]

f7: function [
    {7 - Popularity Contest
    Given a string x, identify the character which occurs most frequently.
    If more than one character occurs the same number of times, you may choose arbitrarily.
    Is it harder to find all such characters?}
    str [string!]
][
    hist: make map! 128
    foreach c str [
        either k: select hist c [
            hist/:c: k + 1
        ][
            put hist c 1
        ]
    ]
    ;last sort/skip reverse to block! hist 2  ; uncomment to find the single most popular character
    sorted: sort/skip reverse to block! hist 2
    rev: tail sorted
    mostpop: rev/-2
    collect [
        until [
            keep rev/-1
            rev: skip rev -2
            rev/-2 < mostpop
        ]
    ]
]

f8: function [
    {8 - esreveR A ecnetneS
    Given a string x consisting of words (one or more non-space characters) which are separated by spaces,
    reverse the order of the characters in each word.} 
    str [string!]
][
    str: split str space
    forall str [str/1: reverse str/1]
    form str
]

f9: function [
    {9 - Compression Session
    Given a string x and a boolean vector y of the same length,
    extract the characters of x corresponding to a 1 in y.}
    str [string!]
    mask [block!]
][
    i: 0
    remove-each _ str[zero? mask/(i: i + 1)]
    str
]

f10: function [
    {10 - Expansion Mansion
    Given a string x and a boolean vector y, spread the characters of x
    to the positions of 1s in y, filling intervening characters with underscores.}
    str [string!]
    mask [block!]
][
    parse mask [
        any [
              change quote 0 "_"
            | change quote 1 (str/1) (str: next str)
        ]
    ]
    rejoin mask
]

f11: function [
    {11 - C_ns_n_nts
    Given a string x, replace all the vowels (a, e, i, o, u, or y) with underscores.}
    str [string!]
][
    replace/all str charset "aeiouyAEIOUY" "_"
]

f12: function [
    {12 - Cnsnnts Rdx
    Given a string x, remove all the vowels entirely.}
    str [string!]
][
    trim/all/with str "aeiouyAEIOUY"
]

f13: function [
    {13 - TITLE REDACTED
    Given a string x consisting of words separated by spaces (as above),
    and a string y, replace all words in x which are the same as y with a series of xes.}
    str [string!]
    word [string!]
][
    xword: copy ""
    append/dup xword "X" length? word
    replace/all str word xword
]

f14: function[
    {14 - It’s More Fun to Permute
    Given a string x, generate a list of all possible reorderings
    of the characters in x.}
    s
][
    either single? s [
        s
    ][
        collect [
            repeat i length? s [
                keep collect [
                    foreach p f14 head remove at copy s i [
                        keep rejoin [s/:i p]
                    ]    
                ]                
            ]
        ]
    ]
]

print "0 - Multiplicity"
foreach [word char] [
    "fhqwhgads" #"h"
    "mississippi" #"s"
    "life" #"."
][
    print [word "," char "->" f0 word char] 
]

print "^/1 - Trapeze Part"
foreach word [
    "racecar"
    "wasitaratisaw"
    "palindrome"    
][print [word "->" f1 word]]

print "^/2 - Duplicity"
foreach word [
    "applause"
    "foo"
    "baz"
][print [form word "->" f2 word]]

print "^/3 - Sort Yourself Out"
foreach [a b][
    "teapot" "toptea"
    "apple" "elap"
    "listen" "silent"
][print [mold a mold b "->" f3 a b]]

print "^/4 - Precious Snowflakes"
foreach string [
    "somewhat heterogenous"
    "aaabccddefffgg"
][ print [string "->" f4 string]]

print "^/5 - Musical Chars"
foreach [w1 w2][
    "foobar" "barfoo"
    "fboaro" "foobar"
    "abcde" "deabc"
][print [form w1 ";" w2 "->" f5 w1 w2]]

print "^/6 - Size Matters"
block: ["books" "apple" "peanut" "aardvark" "melon" "pie"]
print [mold block "->" f6 block]

print "^/7 - Popularity Contest"
foreach word [
    "abdbbac"
    "CCCBBBAA"
    "CCCBBBBAA"
][print [word "->" f7 word]]

print "^/8 - esreveR A ecnetneS"
foreach string [
    "a few words in a sentence"
    "zoop"
    "one two three four"
][print [form string "->" f8 string]]

print "^/9 - Compression Session"
foreach [str mask][
    "foobar" [1 0 0 1 0 1]
    "embiggener" [0 0 1 1 1 1 0 0 1 1]
][print [form str mold mask "->" f9 str mask]]

print "^/10 - Expansion Mansion"
foreach [str mask][
    "fbr" [1 0 0 1 0 1]
    "bigger" [0 0 1 1 1 1 0 0 1 1]
][print [str mold mask "->" f10 str mask]]

print "^/11 - C_ns_n_nts"
foreach str [
    "FLAPJACKS"
    "Several normal words"
][print [copy str "->" f11 str]]

print "^/12 - Cnsnnts Rdx"
foreach str [
    "Several normal words"
    "FLAPJACKS"
][print [copy str "->" f12 str]]   

print "^/13 - TITLE REDACTED"
foreach [string word][
    "a few words in a sentence" "words"
    "one fish two fish" "fish"
    "I don't give a care" "care"
][print [copy string "," word "->" f13 string word]]

print "^/14 - It’s More Fun to Permute"
print f14 "xyz"
print f14 "abcd"
