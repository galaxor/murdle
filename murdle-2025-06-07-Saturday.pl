% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[agent_fuchsia, _, _, _],
     [father_mango, _, _, _],
     [lady_violet, _, _, _],
     [sister_lapis, _, _, _]],

  % What are the weapons
  member([_, trained_vicious_rabbit, _, _], L),
  member([_, ace_of_spades, _, _], L),
  member([_, bottle_of_cheap_liquor, _, _], L),
  member([_, saw, _, _], L),

  % Where are the locations
  member([_, _, private_library, _], L),
  member([_, _, main_stage, _], L),
  member([_, _, piano_room, _], L),
  member([_, _, close_up_table, _], L),

  % Why are the motives
  member([_, _, _, break_into_the_industry], L),
  member([_, _, _, inherit_a_fortune], L),
  member([_, _, _, rob_the_victim], L),
  member([_, _, _, kill], L),

  % Clues.
  findall(Person, member([Person, _, _, _], L), People),
    second_tallest(People, SecondTallestPerson),
    \+member([SecondTallestPerson, _, close_up_table, _], L),
  made_of(LadyVioletWeapon, paper), member([lady_violet, LadyVioletWeapon, _, _], L),
  right_handed(PrivateLibraryPerson), member([PrivateLibraryPerson, _, private_library, _], L),
  member([father_mango, saw, _, _], L),
  member([sister_lapis, trained_vicious_rabbit, _, _], L),
  member([_, _, piano_room, rob_the_victim], L),
  member([_, _, main_stage, break_into_the_industry], L),
  \+member([_, ace_of_spades, _, inherit_a_fortune], L),
  statements_liar([
    statement(agent_fuchsia, \+member([lady_violet, _, private_library, _], L)),
    statement(father_mango, member([_, saw, piano_room, _], L)),
    statement(lady_violet, member([_, trained_vicious_rabbit, main_stage, _], L)),
    statement(sister_lapis, \+member([_, bottle_of_cheap_liquor, piano_room, _], L))
  ], Liar)
.

murdler(Liar, W, L, M) :-
  solution(S, Liar),
  member([Liar, W, L, M], S)
.
