% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    captain_slate,
    amazing_aureolin,
    lord_lavendar,
    principal_applegreen
  ], L),

  % What are the weapons
  weapons([
    ski_pole,
    poisoned_hot_chocolate,
    snowboard,
    flare_gun
  ], L),

  % Where are the locations
  locations([
    lodge,
    woods,
    slopes,
    bar_in_town
  ], L),

  % Clues.
  right_handed(BarPerson), suspect_at_location(BarPerson, bar_in_town, L),
  light_weight(AmazingAureolinWeapon), suspect_had_weapon(amazing_aureolin, AmazingAureolinWeapon, L),
  right_handed(SkiPolePerson), suspect_had_weapon(SkiPolePerson, ski_pole, L),
  \+weapon_at_location(ski_pole, bar_in_town, L),
  one_is_lie([
    weapon_at_location(poisoned_hot_chocolate, woods, L),
    suspect_had_weapon(lord_lavendar, snowboard, L)
  ]),
  \+weapon_at_location(snowboard, bar_in_town, L),
  suspect_at_location(principal_applegreen, bar_in_town, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, flare_gun, _]
.
