NB. solutions to http://beyondloom.com/blog/strings.html in J
NB. Galen Ivanov, 2020

NB. 0 - Multiplicity
NB. Given a string x and a character y, how many times does y occur in x?

f0 =. 1#.=
echo 'fhqwhgads' f0 'h'
echo 'mississippi' f0 's'
echo 'life' f0 '.'

NB. 1 - Trapeze Part
NB. Given a string x, is it identical when read forwards and backwards?

f1 =. -:|.
echo f1 'racecar'
echo f1 'wasitaratisaw'
echo f1 'palindrome'

NB. 2 - Duplicity
NB. Given a string x, produce a list of characters which appear more than once in x.

f2 =. ~.#~1<#/.~
echo f2 'applause'
echo f2 'foo'
echo f2 'baz'

NB. 3 - Sort Yourself Out
NB. Given strings x and y, do both strings contain the same letters, possibly in a different order?

f3 =.-:&(/:~)
echo 'teapot' f3 'toptea'
echo 'apple' f3 'elap'
echo 'listen' f3 'silent'

NB. 4 - Precious Snowflakes
NB. Given a string x, find all the characters which occur exactly once, in the order they appear.   

f4 =. ~.#~1=#/.~
echo f4 'somewhat heterogenous'
echo f4 'aaabccddefffgg'

NB. 5 - Musical Chars
NB. Given strings x and y, is x a rotation of the characters in y?

f5 =. 1 e.[-:"1(#\)@]|."0 1]
echo 'foobar' f5 'barfoo'
echo 'fboaro' f5 'foobar'
echo 'abcde' f5 'deabc'

NB. 6 - Size Matters
NB. Given a list of strings x, sort the strings by length, ascending.

f6 =. /:#&.>
echo f6 'books';'apple';'peanut';'aardvark';'melon';'pie'

NB. 7 - Popularity Contest
NB. Given a string x, identify the character which occurs most frequently.
NB. If more than one character occurs the same number of times, you may choose arbitrarily.
NB. Is it harder to find all such characters?   

f7 =. 0{~.\:#/.~
echo f7 'abdbbac'
echo f7 'CCCBBBAA'
echo f7 'CCCBBBBAA'

NB. All such characters:
f7all =. ~.#~[:(]=>./)#/.~
echo f7all 'abdbbac'
echo f7all 'CCCBBBAA'
echo f7all 'abaacbb'
echo f7all 'abaacccbb'
   
NB. 8 - esreveR A ecnetneS
NB. Given a string x consisting of words (one or more non-space characters) which are separated by spaces,
NB. reverse the order of the characters in each word.

f8 =. |.&.>&.;:
echo f8 'a few words in a sentence'
echo f8 'zoop'
echo f8 'one two three four'

NB. 9 - Compression Session
NB. Given a string x and a boolean vector y of the same length, extract the characters of x corresponding to a 1 in y.

f9 =. #~
echo 'foobar' f9 1 0 0 1 0 1
echo 'embiggener' f9 0 0 1 1 1 1 0 0 1 1

NB. 10 - Expansion Mansion
NB. Given a string x and a boolean vector y, spread the characters of x to the positions of 1s in y,
NB. filling intervening characters with underscores.

f10 =. (*+/\)@]{'_',[
echo 'fbr' f10 1 0 0 1 0 1
echo 'bigger' f10 0 0 1 1 1 1 0 0 1 1

NB. 11 - C_ns_n_nts
NB. Given a string x, replace all the vowels (a, e, i, o, u, or y) with underscores.

f11 =. ('aeiouyAEIOUY'e.~])`(,:'_'$~#)}   NB. using 'Composite item' }
echo f11 'FLAPJACKS'
echo f11 'Several normal words'

NB. 12 - Cnsnnts Rdx
NB. Given a string x, remove all the vowels entirely.

f12 =. #~1-'aeiouyAEIOUY'e.~]
f12 'FLAPJACKS'
f12 'Several normal words'

NB. 13 - TITLE REDACTED
NB. Given a string x consisting of words separated by spaces (as above), and a string y,
NB. replace all words in x which are the same as y with a series of xes.

NB. f13=.[`(('X'$~#)&.>@[)@.e."0 1&.;:
f1 3=. rplc(;'X'$~#)@]
echo 'a few words in a sentence' f13 'words'
echo 'one fish two fish' f13 'fish'
echo 'I dont give a care' f13 'care'

NB. 14 - Itâ€™s More Fun to Permute
NB. Given a string x, generate a list of all possible reorderings of the characters in x.
NB. Can you do this non-recursively?

f14 =. {~[:~.[:/:"1##.inv"0#i.@^#  NB. Inefficient for strings/list with length > 6
echo f14 'xyz'
f14rec =. ]`(,"0 1$:"1@-."1 0~)@.(*@#)  NB. needs formatting
echo f14rec 'abcd'
g14 =. A.~i.@!@#  NB. using J primitive A. (anagram)
echo g14 'abc'
