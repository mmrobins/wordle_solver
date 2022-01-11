# Wordle Solver

Wanna take all the fun out of the game https://www.powerlanguage.co.uk/wordle/ with a little CLI script?

Run the `wordle` file in this repo with 2 args per guess: the guess word and guess result

It will output the possible words sorted to include the letters most frequently used in the wordle dictionary.

e.g. one guess:

    % ./wordle their xo~~x
    Guess word: their
    Guess result: xo~~x
    7 possible words

    chief - 3000
    whine - 3063
    chime - 3086
    chide - 3163
    while - 3207
    shied - 3355
    shine - 3537

    7 possible words

e.g. two guesses:

    $ ./wordle their xo~~x whine oooxo
    Guess word: their
    Guess result: xo~~x
    7 possible words

    Guess word: whine
    Guess result: oooxo
    1 possible words

    while - 3207

If you just wanna know the best first word to try based on letter frequency you can run it without any arguments

    % ./wordle
    ...
    irate - 4511
    arose - 4534
    alter - 4559
    alert - 4559
    later - 4559

Guess results must be 5 charactes of the form

    x = letter miss
    o = letter hit in right place
    ~ = letter hit in wrong place

Need Ruby installed

Note the word list is in the website's javascript, so I've manually extracted
that to this repo, but it could get out of date, so uncommenting a single line
of code can download a full english dictionary

    #five_letter_words = use_full_dictionary

Of course, this is all really a moot point since the answer to every single day
is embedded in the javascript code for the website.  You can just pull each
day's answer out of the browser's localstorage using the browser console

    JSON.parse(localStorage.gameState).solution

Or if you wanna see the answer for any given day, you can run a little
javascript snippet (de-obfuscated from the original JS)

    function solve(solveDate) {
      var anchorDate = new Date(2021,5,19,0,0,0,0),
          dateDiff = solveDate - anchorDate,
          wordIndex = Math.floor(dateDiff / 864e5) % wordList.length;
      return wordList[wordIndex];
    }

Just put the word list from this repo into a variable called `wordList` and run
that function, passing in the whatever date you want the solution for
