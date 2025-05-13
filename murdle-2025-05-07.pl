% This solves 2025-05-04.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[president_amaranth, _, _],
     [dr_crimson, _, _],
     [miss_saffron, _, _]],

  % What are the weapons
  member([_, axe, _], L),
  member([_, bear_trap, _], L),
  member([_, karate_hands, _], L),

  % Where are the locations
  member([_, _, docks], L),
  member([_, _, cliffs], L),
  member([_, _, ancient_ruins], L),

  % Clues.
  eyes(CliffsPerson, hazel), member([CliffsPerson, _, cliffs], L),
  findall(Person, member([Person, _, _], L), People),
    second_tallest(People, SecondTallest),
    (\+member([SecondTallest, axe, _], L)),
  
  % Statements
  statements([president_amaranth, dr_crimson, miss_saffron],
    [member([_, karate_hands_ancient_ruins], L),
      member([president_amaranth, bear_trap, _], L),
      member([president_amaranth, _, docks], L)
    ],
    Liar
  )
.

murdler(Liar, W, L) :-
  solution(S, Liar),
  member([Liar, W, L], S)
.
