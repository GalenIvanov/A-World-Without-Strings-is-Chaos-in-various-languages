! Copyright (C) 2020 Galen Ivanov
! Exercises on strings, source: http://beyondloom.com/blog/strings.html

USING: arrays assocs io kernel math math.ranges math.statistics
prettyprint sequences sequences.extras sequences.repeating sets
sorting splitting strings math.combinatorics ;
IN: A-World-Without-Strings-is-Chaos

! -----------------------------------------------------------------------------
! 0 - Multiplicity
! Given a string x and a character y, how many times does y occur in x?

: f0 ( s s -- n ) last [ = ] curry count ;

! -----------------------------------------------------------------------------
! 1 - Trapeze Part
! Given a string x, is it identical when read forwards and backwards?

: f1 ( s -- ? ) dup reverse = ;

! -----------------------------------------------------------------------------
! 2 - Duplicity
! Given a string x, produce a list of characters which appear more than once in x.

: f2 ( s -- s ) dup duplicates intersect ;

! -----------------------------------------------------------------------------
! 3 - Sort Yourself Out
! Given strings x and y, do both strings contain the same letters, possibly in a different order?

: f3 ( s s -- ? ) [ natural-sort ] bi@ = ;

! -----------------------------------------------------------------------------
! 4 - Precious Snowflakes
! Given a string x, find all the characters which occur exactly once, in the order they appear.

: f4 ( s -- s ) dup duplicates diff ;

! -----------------------------------------------------------------------------
! 5 - Musical Chars
! Given strings x and y, is x a rotation of the characters in y?

: f5 ( s s -- ? ) dup length [1,b]
     [ rotate = ] 2with map
     [ ] any? ;

! -----------------------------------------------------------------------------	 
! 6 - Size Matters
! Given a list of strings x, sort the strings by length, ascending.	 

: f6 ( s -- s ) [ length ] sort-with ;

! -----------------------------------------------------------------------------	 
! 7 - Popularity Contest
! Given a string x, identify the character which occurs most frequently.
! If more than one character occurs the same number of times,
! you may choose arbitrarily. Is it harder to find all such characters?

: f7 ( s -- s ) sorted-histogram last first 1string ;

: f7all ( s -- s ) sorted-histogram
        unzip dup last swap indices
        swap nths >string ;

! -----------------------------------------------------------------------------	 
! 8 - esreveR A ecnetneS
! Given a string x consisting of words (one or more non-space characters)
! which are separated by spaces, reverse the order of the characters in each word.

: f8 ( s -- s ) " " split [ reverse ] map " " join ;

! -----------------------------------------------------------------------------	 
! 9 - Compression Session
! Given a string x and a boolean vector y of the same length,
! extract the characters of x corresponding to a 1 in y.

: f9 ( s s -- s ) 1 swap indices swap nths ;

! -----------------------------------------------------------------------------	 
! 10 - Expansion Mansion
! Given a string x and a boolean vector y, spread the characters of x
! to the positions of 1s in y, filling intervening characters with underscores.

: f10 ( s s -- s ) [ cum-sum ] keep [ * ] 2map swap "_" prepend nths ;

! -----------------------------------------------------------------------------	 
! 11 - C_ns_n_nts
! Given a string x, replace all the vowels (a, e, i, o, u, or y) with underscores.

: f11 ( s -- s ) [ "aoeiuyAOEIUY" member? ] split-when "_" join ;

! -----------------------------------------------------------------------------	 
! 12 - Cnsnnts Rdx
! Given a string x, remove all the vowels entirely.

: f12 ( s -- s ) [ "aoeiuyAOEIUY" member? ] reject ;

! -----------------------------------------------------------------------------
! 13 - TITLE REDACTED
! Given a string x consisting of words separated by spaces (as above),
! and a string y, replace all words in x which are the same as y with a series of xes.

: f13 ( s s -- s ) dup length "X" swap cycle replace ;

! -----------------------------------------------------------------------------
! 14 - It’s More Fun to Permute
! Given a string x, generate a list of all possible reorderings
! of the characters in x. Can you do this non-recursively?

: f14 ( s -- s ) <permutations> >array ;


! -----------------------------------------------------------------------------
! -----------------------------------------------------------------------------
! Tests
! -----------------------------------------------------------------------------
! -----------------------------------------------------------------------------

"0 - Multiplicity" print
"fhqwhgads" "h" f0 .
"mississippi" "s" f0 .
"life" "." f0 .

"1 - Trapeze part" print
{ "racecar" "wasitaratisaw" "palindrome" } [ f1 ] map .

"2 Duplicity" print
{ "applause" "foo" "baz" } [ f2 ] map .

"3 - Sort Yourself Out" print
"teapot" "toptea" f3 .
"apple" "elap" f3 .
"listen" "silent" f3 .

"4 - Precious Snowflakes" print
{ "somewhat heterogenous" "aaabccddefffgg" } [ f4 ] map .

"5 - Musical Chars" print
"foobar" "barfoo" f5 .
"fboaro" "foobar" f5 .
"abcde" "deabc" f5 .

"6 - Size Matters" print
{ "books" "apple" "peanut" "aardvark" "melon" "pie" } f6 .

"7 - Popularity Contest" print 
{ "abdbbac" "CCCBBBAA" "CCCBBBBAA" } [ f7 ] map .
{ "aabdbbac" "CCCBBBAA" "Mississippi" } [ f7all ] map .

"8 - esreveR A ecnetneS" print
{ "a few words in a sentence" "zoop" "one two three four" } [ f8 ] map .

"9 - Compression Session" print
"foobar" { 1 0 0 1 0 1 } f9 .
"embiggener" { 0 0 1 1 1 1 0 0 1 1 } f9 .

"10 - Expansion Mansion" print
"fbr" { 1 0 0 1 0 1 } f10 .
"bigger" { 0 0 1 1 1 1 0 0 1 1 } f10 .

"11 - C_ns_n_nts" print
{ "FLAPJACKS" "Several normal words" } [ f11 ] map .

"12 - Cnsnnts Rdx" print
{ "Several normal words" "FLAPJACKS" } [ f12 ] map .

"13 - TITLE REDACTED" print
"a few words in a sentence" "words" f13 .
"one fish two fish" "fish" f13 .
"I don't give a care" "care" f13 .

"14 - It’s More Fun to Permute" print
"xyz" f14 .
