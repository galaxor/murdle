% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    secretary_celadon,
    general_coffee,
    lady_violet,
    dame_obsidian,
    chancellor_tuscany
  ], L),

  % What are the weapons
  weapons([
    murdle_volume_1,
    metal_straw,
    boiling_pot,
    butter_knife,
    poisoned_cup_of_coffee
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
  hair(BeanRoomPerson, brown), suspect_at_location(BeanRoomPerson, bean_room, L),
  one_is_lie([
    suspect_had_weapon(lady_violet, boiling_pot, L),
    suspect_at_location(general_coffee, counter, L)
  ]),
  second_tallest_suspect(SecondTallest, L), \+suspect_had_weapon(SecondTallest, metal_straw, L),
  birthday(ParkingLotPerson, august, 28), suspect_at_location(ParkingLotPerson, parking_lot, L),
  weapon_at_location(butter_knife, counter, L),
  made_of(DameObsidianWeapon, paper), suspect_had_weapon(dame_obsidian, DameObsidianWeapon, L),
  right_handed(BathroomPerson), suspect_at_location(BathroomPerson, bathroom, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, murdle_volume_1, _]
.
