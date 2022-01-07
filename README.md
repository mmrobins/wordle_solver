# Wordle Solver

Wanna take all the fun out of the game https://www.powerlanguage.co.uk/wordle/ with a little CLI script?

run the `wordle` file in this repo with 2 args per guess: the guess word and guess result

e.g. one guess:

    $ ./wordle their xo~~x
    Guess word: their
    Guess result: xo~~x
    7 possible words:

    chide
    chief
    ...

e.g. two guesses:

    $ ./wordle their xo~~x whine oooxo
    Guess word: their
    Guess result: xo~~x
    7 possible words

    Guess word: whine
    Guess result: oooxo
    1 possible words

    while

Guess results must be 5 charactes of the form

    x = letter miss
    o = letter hit in right place
    ~ = letter hit in wrong place

Need Ruby installed

Note the word list is in the website's javascript, so I've manually extracted
that to this repo, but it could get out of date, so uncommenting a single line
of code can download a full english dictionary

    #five_letter_words = use_full_dictionary

