% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[uncle_midnight, _, _, _],
     [officer_copper, _, _, _],
     [sister_lapis, _, _, _]],

  % What are the weapons
  member([_, hyper_allergenic_oil, _, _], L),
  member([_, crystal_dagger, _, _], L),
  member([_, ghost_detector, _, _], L),

  % Where are the locations
  member([_, _, observatory, _], L),
  member([_, _, minigolf_course, _], L),
  member([_, _, hedge_maze, _], L),

  % Why are the motives
  member([_, _, _, hide_an_affair], L),
  member([_, _, _, win_an_argument], L),
  member([_, _, _, escape_blackmail], L),

  % Clues.
  member([_, _, minigolf_course, hide_an_affair], L),
  light_weight(SisterLapisWeapon), member([sister_lapis, SisterLapisWeapon, _, _], L),
  made_of(WinArgumentWeapon, crystal), member([_, WinArgumentWeapon, _, win_an_argument], L),
  outdoors(OfficerCopperPlace), member([officer_copper, _, OfficerCopperPlace, _], L),
  one_is_lie([
    member([uncle_midnight, _, observatory, _], L),
    member([_, crystal_dagger, observatory, _], L)
  ])
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, ghost_detector, _, _]
.
