% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    silverton_the_legend,
    coach_raspberry,
    judge_pine,
    duchess_of_vermillion
  ], L),

  % What are the weapons
  weapons([
    trained_vicious_rabbit,
    corgi_stampede,
    fake_sword,
    bottle_of_cheap_liquor
  ], L),

  % Where are the locations
  locations([
    piano_room,
    parking_lot,
    private_library,
    close_up_table
  ], L),

  % Clues.
  hair(CheapLiquorPerson, black), suspect_had_weapon(CheapLiquorPerson, bottle_of_cheap_liquor, L),
  eyes(PianoRoomPerson, grey), suspect_at_location(PianoRoomPerson, piano_room, L),
  heavy_weight(ParkingLotWeapon), weapon_at_location(ParkingLotWeapon, parking_lot, L),
  one_is_lie([
    suspect_at_location(silverton_the_legend, parking_lot, L),
    weapon_at_location(corgi_stampede, piano_room, L)
  ]),
  weapon_at_location(trained_vicious_rabbit, close_up_table, L),
  \+suspect_at_location(silverton_the_legend, parking_lot, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, fake_sword, _]
.
