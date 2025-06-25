% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    baron_maroon,
    mayor_honey,
    brother_brownstone
  ], L),

  % What are the weapons
  weapons([
    fishing_spear,
    poisoned_cocktail,
    commemorative_sword
  ], L),

  % Where are the locations
  locations([
    swim_up_bar,
    dining_hall,
    lifeguard_stand
  ], L),

  % Clues.
  \+suspect_at_location(mayor_honey, swim_up_bar, L),
  light_weight(BrotherBrownstoneWeapon), suspect_had_weapon(brother_brownstone, BrotherBrownstoneWeapon, L),
  statements_liar([
    statement(baron_maroon, suspect_at_location(baron_maroon, dining_hall, L)),
    statement(mayor_honey, weapon_at_location(commemorative_sword, dining_hall, L)),
    statement(brother_brownstone, weapon_at_location(fishing_spear, lifeguard_stand, L))
  ], Liar)
.

murdler(Liar, W, L) :-
  solution(S, Liar),
  member([Liar, W, L], S)
.
