% This solves 2025-05-10.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[secretary_celadon, _, _, _],
     [brother_brownstone, _, _, _],
     [bishop_azure, _, _, _],
     [miss_ruby, _, _, _]],

  % What are the weapons
  member([_, walking_stick, _, _], L),
  member([_, laptop, _, _], L),
  member([_, newspaper_crowbar, _, _], L),
  member([_, climbing_rope, _, _], L),

  % Where are the locations
  member([_, _, boutique_hotel, _], L),
  member([_, _, five_star_restaurant, _], L),
  member([_, _, real_estate_office, _], L),
  member([_, _, gift_shop, _], L),

  % Why are the motives
  member([_, _, _, fight_for_the_revolution], L),
  member([_, _, _, hide_an_affair], L),
  member([_, _, _, escape_blackmail], L),
  member([_, _, _, rage_with_jealousy], L),

  % Clues.
  eyes(HotelPerson, green), member([HotelPerson, _, boutique_hotel, _], L),
  hair(RevolutionPerson, brown), member([RevolutionPerson, _, _, fight_for_the_revolution], L),
  member([secretary_celadon, laptop, _, _], L),
  member([_, newspaper_crowbar, gift_shop, _], L),
  member([brother_brownstone, _, _, escape_blackmail], L),
  \+member([_, walking_stick, _, rage_with_jealousy], L),
  member([bishop_azure, _, _, hide_an_affair], L),
  speakers_statements_liar(
    [secretary_celadon, brother_brownstone, bishop_azure, miss_ruby],
    [member([brother_brownstone, walking_stick, _, _], L),
      \+member([brother_brownstone, newspaper_crowbar, _, _], L),
      member([_, walking_stick, five_star_restaurant, _], L),
      member([_, walking_stick, five_star_restaurant, _], L)
    ],
    Liar
  )
.

murdler(Liar, W, L, M) :-
  solution(S, Liar),
  member([Liar, W, L, M], S)
.
