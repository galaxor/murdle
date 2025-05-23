% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[dr_crimson, _, _],
     [vice_president_mauve, _, _],
     [lord_lavendar, _, _],
     [earl_grey, _, _]],

  % What are the weapons
  member([_, crazed_squirrel, _], L),
  member([_, old_heavy_tome, _], L),
  member([_, poisoned_goblet, _], L),
  member([_, ancient_plague, _], L),

  % Where are the locations
  member([_, _, moat], L),
  member([_, _, great_hall], L),
  member([_, _, secret_chamber], L),
  member([_, _, dungeon], L),

  % Clues.
  \+member([dr_crimson, crazed_squirrel, _], L),
  light_weight(VicePresidentMauveWeapon), member([vice_president_mauve, VicePresidentMauveWeapon, _], L),
  member([lord_lavendar, old_heavy_tome, _], L),
  sign(DungeonPerson, aquarius), member([DungeonPerson, _, dungeon], L),
  eyes(GreatHallPerson, brown), member([GreatHallPerson, _, great_hall], L),
  one_is_lie([
    member([_, poisoned_goblet, moat], L),
    member([earl_grey, _, dungeon], L)
  ])
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, secret_chamber]
.
