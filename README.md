This is a repo where I learn how to write in Prolog by writing programs to solve the daily puzzle game [Murdle](https://murdle.com).

The file `murdle.pl` has rules we use in figuring the solution, as well as facts about the various suspects and weapons who may appear in each puzzle.  I believe that if a particular suspect appears in a puzzle, they'll always have the same biographical facts.  Each day, I only add enough facts to solve a particular day's challenge, but eventually, the database of facts will be complete (if the facts work like I think they do).

Then the various `murdle-YYYY-MM-DD.pl` files have the particular clues to solve a particular day's puzzle.

To run this, start up your prolog interpreter (I'm using [SWI-Prolog](https://www.swi-prolog.org/), but I'm trying to maintain compatibility with [GNU Prolog](http://gprolog.org/)).

From the `?-` prompt, load the day's puzzle and run the appropriate one of these commands:
* `murdler(P, W, L).` to solve the puzzle.  P will be the suspect, W will be the weapon, and L will be the location.
* If it's a puzzle that has motives, use `murdler(P, W, L, M)`, and M will be the motive.  

Here's a sample run.

```
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

| ?- ['murdle-2025-05-04'].
compiling /path/to/murdle/murdle-2025-05-04.pl for byte code...
/path/to/murdle/murdle-2025-05-04.pl compiled, 48 lines read - 7630 bytes written, 4 ms

(2 ms) yes
| ?- murdler(P,W,L).
compiling /path/to/murdle/murdle.pl for byte code...
/path/to/murdle/murdle.pl compiled, 50 lines read - 8507 bytes written, 3 ms

L = cafeteria
P = president_amaranth
W = bottle ? ;

(417 ms) no
```

When there comes to be a puzzle where we also have to solve the motive, I'll have to make it be `murdler(P,W,M,L).` to solve the person, weapon, motive, and location.
