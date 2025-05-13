% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[dr_crimson, _, _, _],
     [grandmaster_rose, _, _, _],
     [father_mango, _, _, _]],

  % What are the weapons
  member([_, brick_of_coal, _, _], L),
  member([_, italian_knife, _, _], L),
  member([_, wine, _, _], L),

  % Where are the locations
  member([_, _, roof, _], L),
  member([_, _, locomotive, _], L),
  member([_, _, sleeping_car, _], L),

  % Why are the motives
  member([_, _, _, fight_for_the_revolution], L),
  member([_, _, _, rob_the_victim], L),
  member([_, _, _, hide_an_affair], L),

  % Clues.
  made_of(HideAffairWeapon, metal), member([_, HideAffairWeapon, _, hide_an_affair], L),
  eyes(LocomotivePerson, brown), member([LocomotivePerson, _, locomotive, _], L),
  eyes(WinePerson, brown), member([WinePerson, wine, _, _], L),
  \+member([grandmaster_rose, _, _, rob_the_victim], L),
  member([dr_crimson, _, _, fight_for_the_revolution], L),
  one_is_lie([
    member([_, italian_knife, roof, _], L),
    member([father_mango, brick_of_coal, _, _], L)
  ])
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, _, sleeping_car, _]
.
