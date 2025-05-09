% This solves 2025-05-09.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[principal_applegreen, _, _],
     [dame_obsidian, _, _],
     [general_coffee, _, _],
     [babyface_blue, _, _],
     [lord_lavendar, _, _]],

  % What are the weapons
  member([_, award, _], L),
  member([_, golf_cart, _], L),
  member([_, camera, _], L),
  member([_, clapboard, _], L),
  member([_, stage_light, _], L),

  % Where are the locations
  member([_, _, statue_of_midnight], L),
  member([_, _, watertower_bar_grill], L),
  member([_, _, locked_stage], L),
  member([_, _, entrance_gate], L),
  member([_, _, city_backlot], L),

  % Clues.
  member([_, golf_cart, statue_of_midnight], L),
  made_of(ObsidianWeapon, glass), member([dame_obsidian, ObsidianWeapon, _], L),
  member([general_coffee, stage_light, _], L),
  \+member([lord_lavendar, _, watertower_bar_grill], L),
  heavy_weight(LockedStageWeapon), member([_, LockedStageWeapon, locked_stage], L),
  indoors(AwardPlace), member([_, award, AwardPlace], L),
  (
    (member([principal_applegreen, _, entrance_gate], L), \+member([_, golf_cart, locked_stage], L));
    (\+member([principal_applegreen, _, entrance_gate], L), member([_, golf_cart, locked_stage], L))
  )
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L] = [P, clapboard, L]
.
