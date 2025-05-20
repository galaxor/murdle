% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[lady_violet, _, _, _],
     [amazing_aureolin, _, _, _],
     [major_red, _, _, _]],

  % What are the weapons
  member([_, yarn, _, _], L),
  member([_, holy_relic, _, _], L),
  member([_, murdle_volume_3, _, _], L),

  % Where are the locations
  member([_, _, nave, _], L),
  member([_, _, front_steps, _], L),
  member([_, _, vestibule, _], L),

  % Why are the motives
  member([_, _, _, silence_a_witness], L),
  member([_, _, _, break_into_the_industry], L),
  member([_, _, _, fight_for_the_revolution], L),

  % Clues.
  eyes(SilenceAWitnessPerson, brown), member([SilenceAWitnessPerson, _, _, silence_a_witness], L),
  member([_, holy_relic, vestibule, _], L),
  left_handed(FightForTheRevolutionPerson), member([FightForTheRevolutionPerson, _, _, fight_for_the_revolution], L),
  made_of(AmazingAureolinWeapon, wool), member([amazing_aureolin, AmazingAureolinWeapon, _, _], L),
  one_is_lie([
    member([lady_violet, _, nave, _], L),
    member([_, murdle_volume_3, nave, _], L)
  ])
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, _, front_steps, _]
.
