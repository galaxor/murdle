% This solves 2025-05-04.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[captain_slate, _, _, _],
     [sister_lapis, _, _, _],
     [coach_raspberry, _, _, _]],

  % What are the weapons
  member([_, gloves, _, _], L),
  member([_, crystal_ball, _, _], L),
  member([_, dagger, _, _], L),

  % Where are the locations
  member([_, _, hedge_maze, _], L),
  member([_, _, minigolf_course, _], L),
  member([_, _, observatory, _], L),

  % Why are the motives
  member([_, _, _, kill], L),
  member([_, _, _, escape_blackmail], L),
  member([_, _, _, inherit_fortune], L),

  % Clues.
  indoors(SlateLoc), member([captain_slate, _, SlateLoc, _], L),
  (\+member([_, dagger, minigolf_course, _], L)),
  member([_, gloves, _, escape_blackmail], L),
  heavy_weight(KillWp), member([_, KillWp, _, kill], L),
  eyes(EscBlkmailPerson, blue), member([EscBlkmailPerson, _, _, escape_blackmail], L),
  ( (member([coach_raspberry, crystal_ball, _, _], L), \+member([_, crystal_ball, observatory, _], L))
   ;(\+member([coach_raspberry, crystal_ball, _, _], L), member([_, crystal_ball, observatory, _], L))
  )
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, _, hedge_maze, _]
.
