% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    agent_fuchsia,
    principal_applegreen,
    dean_glaucous,
    viscount_eminence
  ], L),

  % What are the weapons
  weapons([
    ordinary_brick,
    bear_trap,
    harpoon,
    kindness
  ], L),

  % Where are the locations
  locations([
    ancient_ruins,
    docks,
    cliffs,
    haunted_grove
  ], L),

  % Clues.
  \+weapon_at_location(harpoon, docks, L),
  suspect_at_location(agent_fuchsia, cliffs, L),
  weapon_at_location(ordinary_brick, ancient_ruins, L),
  eyes(BearTrapPerson, blue), suspect_had_weapon(BearTrapPerson, bear_trap, L),
  made_of(ViscountEminenceWeapon, metal), suspect_had_weapon(viscount_eminence, ViscountEminenceWeapon, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, haunted_grove]
.
