% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    brother_brownstone,
    mx_tangerine,
    sister_lapis,
    viscount_eminence
  ], L),

  % What are the weapons
  weapons([
    award,
    bookie,
    dvd_box_set,
    camera
  ], L),

  % Where are the locations
  locations([
    entrance_gate,
    locked_stage,
    prop_shop,
    studio_tour_check_in_stand
  ], L),

  % Clues.
  sign(LockedStagePerson, capricorn), suspect_at_location(LockedStagePerson, locked_stage, L),
  weapon_at_location(dvd_box_set, entrance_gate, L),
  suspect_had_weapon(mx_tangerine, award, L),
  \+suspect_had_weapon(sister_lapis, bookie, L),
  right_handed(PropShopPerson), suspect_at_location(PropShopPerson, prop_shop, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, studio_tour_check_in_stand]
.
