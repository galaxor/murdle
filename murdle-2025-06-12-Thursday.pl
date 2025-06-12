% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    dean_glaucous,
    secretary_celadon,
    agent_fuchsia,
    grandmaster_rose
  ], L),

  % What are the weapons
  weapons([
    antique_flintlock,
    yarn,
    wine_bottle,
    string_of_prayer_beads
  ], L),

  % Where are the locations
  locations([
    choir_loft,
    graveyard,
    bell_tower,
    vestibule
  ], L),

  % Clues.
  made_of(ChoirLoftWeapon, wool), weapon_at_location(ChoirLoftWeapon, choir_loft, L),
  birthday(VestibulePerson, november, 17), suspect_at_location(VestibulePerson, vestibule, L),
  same_height(dean_glaucous, NonBellTowerPerson), 
    member([NonBellTowerPerson, _, _], L),
    \+suspect_at_location(NonBellTowerPerson, bell_tower, L),
  medium_weight(SecretaryCeladonWeapon), suspect_had_weapon(secretary_celadon, SecretaryCeladonWeapon, L),
  suspect_had_weapon(dean_glaucous, wine_bottle, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, graveyard]
.
