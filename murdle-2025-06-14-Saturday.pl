% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    deacon_verdigris,
    father_mango,
    mayor_honey,
    babyface_blue
  ], L),

  % What are the weapons
  weapons([
    axe,
    poisoned_candle,
    pitchfork,
    channeled_text
  ], L),

  % Where are the locations
  locations([
    barracks,
    library,
    meeting_house,
    ancient_ruins
  ], L),

  % Why are the motives
  motives([
    rage_with_jealousy,
    fight_for_the_revolution,
    eliminate_a_spy,
    inherit_a_fortune
  ], L),

  % Clues.
  \+suspect_had_weapon(father_mango, poisoned_candle, L),
  location_motive(meeting_house, eliminate_a_spy, L),
  suspect_motive(babyface_blue, inherit_a_fortune, L),
  medium_weight(JealousyWeapon), weapon_motive(JealousyWeapon, rage_with_jealousy, L),
  left_handed(AxePerson), suspect_had_weapon(AxePerson, axe, L),
  sign(PitchforkPerson, leo), suspect_had_weapon(PitchforkPerson, pitchfork, L),
  statements_liar([
    statement(deacon_verdigris, weapon_at_location(channeled_text, barracks, L)),
    statement(father_mango, weapon_at_location(poisoned_candle, meeting_house, L)),
    statement(mayor_honey, suspect_at_location(mayor_honey, library, L)),
    statement(babyface_blue, suspect_at_location(father_mango, barracks, L))
  ], Liar)
.

murdler(Liar, W, L, M) :-
  solution(S, Liar),
  member([Liar, W, L, M], S)
.
