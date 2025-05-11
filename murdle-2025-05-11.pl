% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[mx_tangerine, _, _],
     [sister_lapis, _, _],
     [dr_crimson, _, _],
     [lady_violet, _, _],
     [principal_applegreen, _, _],
     [secretary_celadon, _, _]],

  % What are the weapons
  member([_, key, _], L),
  member([_, lawyer, _], L),
  member([_, cake, _], L),
  member([_, cufflinks, _], L),
  member([_, shiv, _], L),
  member([_, bookie, _], L),

  % Where are the locations
  member([_, _, movie_theater], L),
  member([_, _, michelin_starred_cafeteria], L),
  member([_, _, tennis_court], L),
  member([_, _, guard_tower], L),
  member([_, _, rec_room], L),
  member([_, _, spa], L),

  % Clues.
  \+member([sister_lapis, lawyer, _], L),

  findall(Person, member([Person, _, _], L), People),
   tallest(People, MovieTheaterPerson),
   member([MovieTheaterPerson, _, movie_theater], L),


  member([dr_crimson, _, spa], L),
  hair(CafeteriaPerson, brown), member([CafeteriaPerson, _, michelin_starred_cafeteria], L),
  member([_, cufflinks, rec_room], L),
  member([sister_lapis, _, guard_tower], L),
  member([principal_applegreen, cake, _], L),
  member([mx_tangerine, bookie, _], L),
  member([dr_crimson, key, _], L)
.

murdler(P, W, L) :-
  solution(S),
  [P,W,L]=[P,W,tennis_court],
  member([P, W, L], S)
.
