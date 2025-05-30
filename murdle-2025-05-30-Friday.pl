% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[sir_rulean, _, _],
     [mayor_honey, _, _],
     [dean_glaucous, _, _],
     [agent_fuchsia, _, _],
     [general_coffee, _, _]],

  % What are the weapons
  member([_, piano_wire, _], L),
  member([_, poisoned_klonopin, _], L),
  member([_, heavy_candle, _], L),
  member([_, murdle_board_game, _], L),
  member([_, rare_vase, _], L),

  % Where are the locations
  member([_, _, bedroom], L),
  member([_, _, enormous_bathroom], L),
  member([_, _, upstairs_balcony], L),
  member([_, _, grounds], L),
  member([_, _, screening_room], L),

  % Clues.
  \+member([general_coffee, _, enormous_bathroom], L),
  findall(Person, member([Person, _, _], L), People),
    shortest(People, ShortestPerson),
    medium_weight(ShortestPersonWeapon),
    member([ShortestPerson, ShortestPersonWeapon, _], L),
  indoors(AgentFuchsiaPlace), member([agent_fuchsia, _, AgentFuchsiaPlace], L),
  hair(PianoWirePerson, red), member([PianoWirePerson, piano_wire, _], L),
  left_handed(GroundsPerson), member([GroundsPerson, _, grounds], L),
  member([_, heavy_candle, screening_room], L),
  member([_, murdle_board_game, upstairs_balcony], L),
  \+member([dean_glaucous, _, screening_room], L),
  eyes(KlonopinPerson, brown), member([KlonopinPerson, poisoned_klonopin, _], L),
  same_height(mayor_honey, NotCandlePerson), member([NotCandlePerson, _, _], L),
    \+member([NotCandlePerson, heavy_candle, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, bedroom]
.
