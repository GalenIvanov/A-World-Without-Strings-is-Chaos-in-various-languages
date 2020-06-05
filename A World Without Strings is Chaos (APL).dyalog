f0 ← +/=
'fhqwhgads' f0 'h'
'mississippi' f0 's'
'life' f0 '.'

f1 ← ⌽≡⊢
f1¨ 'racecar' 'wasitaratisaw' 'palindrome'

f2 ← ((1<⊢∘≢)⌸⊢){⍺/⍵}∪
f2¨ 'applause' 'foo' 'baz'

f3 ← ≡/(⊂∘⍋⌷⊢)¨
f3 'teapot' 'toptea'
f3 'apple' 'elap'
f3 'listen' 'silent'

f4 ← ((1=⊢∘≢)⌸⊢){⍺/⍵}∪
f4 'somewhat heterogenous'
f4 'aaabccddefffgg'

f5 ← {⌈/⍺(≡⍤1)(⍵(⌽⍤0 1)⍨⍳⍴⍵)}
'foobar' f5 'barfoo'
'fboaro' f5 'foobar'
'abcde' f5 'deabc'

f6 ← {⍵[⍋≢¨⍵]}
f6 'books' 'apple' 'peanut' 'aardvark' 'melon' 'pie'

f7 ←  ({⍵=⌈/⍵}⊢(⊢∘≢⌸)⊢){⍺/⍵}∪
f7¨ 'abdbbac' 'abaacbb' 'abaacccbb'

f8 ← ↑((⊣,' ',⊢)/⌽¨∘(' '(≠⊆⊢)⊢))
f8¨ 'a few words in a sentence' 'zoop' 'one two three four'

f9 ← /⍨
'foobar' f9 (1 0 0 1 0 1)
'embiggener'f9 (0 0 1 1 1 1 0 0 1 1)

f10 ← ('_'@(' '=⊢)){⍺\⍨⍵}
'fbr' f10 (1 0 0 1 0 1)
'bigger' f10 (0 0 1 1 1 1 0 0 1 1)

f11 ← '_'@('aoeiuyAOEIUY'∊⍨⊢)
f11 ¨ 'FLAPJACKS' 'Several normal words'

f12 ← {(~⍵∊'aoeiuyAOEIUY')/⍵}
f12 ¨ 'Several normal words' 'FLAPJACKS'

f13 ← {↑{⍺,' ',⍵}/((⊂'X'⍴⍨≢⍵)@((⊂⍵)∘.≡⊢))' '(≠⊆⊢)⍺}
'A few words in a sentence' f13 'words'
'one fish two fish' f13 'fish'
