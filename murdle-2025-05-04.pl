% This solves 2025-05-04.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[president_amaranth, _, _],
     [vice_president_mauve, _, _],
     [babyface_blue, _, _],
     [silverton_the_legend, _, _],
     [signor_emerald, _, _],
     [mx_tangerine, _, _]],

  % What are the weapons
  member([_, bottle, _], L),
  member([_, cake, _], L),
  member([_, key, _], L),
  member([_, shiv, _], L),
  member([_, cufflinks, _], L),
  member([_, lawyer, _], L),

  % Where are the locations
  member([_, _, rec_room], L),
  member([_, _, private_suite], L),
  member([_, _, guard_tower], L),
  member([_, _, spa], L),
  member([_, _, cafeteria], L),
  member([_, _, theater], L),

  % Clues.
  member([P1, _, spa], L), left_handed(P1),
  member([silverton_the_legend, _, theater], L),
  member([_, cufflinks, guard_tower], L),
  member([SHVPM, _, rec_room], L), same_height(vice_president_mauve, SHVPM), % The suspect with the same height as vice president mauve
  member([Tallest, _, private_suite], L), findall(P2, height(P2, _), People), tallest(People, Tallest),
  member([mx_tangerine, key, _], L),
  member([_, cake, rec_room], L),
  member([president_amaranth, W1, _], L), medium_weight(W1),
  member([_, shiv, private_suite], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, cafeteria]
.
