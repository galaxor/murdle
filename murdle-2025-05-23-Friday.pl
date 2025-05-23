% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[captain_slate, _, _],
     [mx_tangerine, _, _],
     [chancellor_tuscany, _, _],
     [uncle_midnight, _, _],
     [silverton_the_legend, _, _]],

  % What are the weapons
  member([_, ordinary_brick, _], L),
  member([_, axe, _], L),
  member([_, hammer_and_sickle, _], L),
  member([_, bear_trap, _], L),
  member([_, oar, _], L),

  % Where are the locations
  member([_, _, docks], L),
  member([_, _, mysterious_mansion], L),
  member([_, _, cliffs], L),
  member([_, _, ancient_ruins], L),
  member([_, _, haunted_grove], L),

  % Clues.
  indoors(MxTangerineLocation), member([mx_tangerine, _, MxTangerineLocation], L),
  member([captain_slate, ordinary_brick, _], L),
  \+member([_, ordinary_brick, docks], L),
  made_of(CliffsWeapon, wood), member([_, CliffsWeapon, cliffs], L),
  eyes(HammerAndSicklePerson, blue), member([HammerAndSicklePerson, hammer_and_sickle, _], L),
  one_is_lie([
    member([mx_tangerine, _, ancient_ruins], L),
    member([silverton_the_legend, _, haunted_grove], L)
  ]),
  medium_weight(MansionWeapon), member([_, MansionWeapon, mysterious_mansion], L),
  member([uncle_midnight, _, cliffs], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, oar, _]
.
