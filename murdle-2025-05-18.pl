% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[brother_brownstone, _, _],
     [dr_crimson, _, _],
     [coach_raspberry, _, _],
     [officer_copper, _, _],
     [uncle_midnight, _, _],
     [deacon_verdigris, _, _]],

  % What are the weapons
  member([_, key, _], L),
  member([_, golden_handcuffs, _], L),
  member([_, rope_of_clothes, _], L),
  member([_, shiv, _], L),
  member([_, cake, _], L),
  member([_, gold_watch, _], L),

  % Where are the locations
  member([_, _, spa], L),
  member([_, _, movie_theater], L),
  member([_, _, rec_room], L),
  member([_, _, guard_tower], L),
  member([_, _, cafeteria], L),
  member([_, _, tennis_court], L),

  % Clues.
  member([uncle_midnight, shiv, _], L),
  member([_, rope_of_clothes, rec_room], L),
  member([officer_copper, _, guard_tower], L),
  light_weight(BrotherBrownstoneWeapon), member([brother_brownstone, BrotherBrownstoneWeapon, _], L),
  hair(CafeteriaPerson, brown), member([CafeteriaPerson, _, cafeteria], L),
  member([deacon_verdigris, cake, _], L),
  member([_, key, movie_theater], L),
  findall(Person, member([Person, _, _], L), People), tallest(People, TallestPerson), member([TallestPerson, golden_handcuffs, _], L),
  member([_, golden_handcuffs, spa], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P,W,L]=[_, _, tennis_court]
.
