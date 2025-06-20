% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    dame_obsidian,
    secretary_celadon,
    admiral_navy,
    miss_ruby,
    earl_grey
  ], L),

  % What are the weapons
  weapons([
    murdle_volume_1,
    boiling_pot,
    butter_knife,
    poisoned_cup_of_coffee,
    metal_straw
  ], L),

  % Where are the locations
  locations([
    bean_room,
    counter,
    parking_lot,
    bathroom,
    courtyard
  ], L),

  % Clues.
  \+suspect_had_weapon(dame_obsidian, murdle_volume_1, L),
  one_is_lie([
    suspect_at_location(admiral_navy, bean_room, L),
    suspect_had_weapon(admiral_navy, butter_knife, L)
  ]),
  weapon_at_location(poisoned_cup_of_coffee, bathroom, L),
  birthday(ParkingLotPerson, september, 28), suspect_at_location(ParkingLotPerson, parking_lot, L),
  weapon_at_location(metal_straw, parking_lot, L),
  eyes(BathroomPerson, brown), suspect_at_location(BathroomPerson, bathroom, L),
  outdoors(SecretaryCeladonLocation), suspect_at_location(secretary_celadon, SecretaryCeladonLocation, L),
  made_of(AdmiralNavyWeapon, water), suspect_had_weapon(admiral_navy, AdmiralNavyWeapon, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, courtyard]
.
