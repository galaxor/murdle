% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    sister_lapis,
    comrade_champagne,
    viscount_eminence
  ], L),

  % What are the weapons
  weapons([
    fire_extinguisher,
    kindness,
    clipboard
  ], L),

  % Where are the locations
  locations([
    parking_lot,
    roof,
    waiting_room
  ], L),

  % Clues.
  \+weapon_at_location(fire_extinguisher, waiting_room, L),
  eyes(ClipboardPerson, grey), suspect_had_weapon(ClipboardPerson, clipboard, L),
  statements_liar([
    statement(sister_lapis, suspect_had_weapon(comrade_champagne, kindness, L)),
    statement(comrade_champagne, weapon_at_location(clipboard, parking_lot, L)),
    statement(viscount_eminence, suspect_at_location(sister_lapis, roof, L))
  ], Liar)
.

murdler(Liar, W, L) :-
  solution(S, Liar),
  member([Liar, W, L], S)
.
