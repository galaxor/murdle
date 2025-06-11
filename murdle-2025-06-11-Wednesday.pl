% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    uncle_midnight,
    silverton_the_legend,
    judge_pine
  ], L),

  % What are the weapons
  weapons([
    poisoned_cocktail,
    bottle_of_wine,
    greenskeepers_chainsaw
  ], L),

  % Where are the locations
  locations([
    tennis_court,
    caddy_shack,
    mens_lounge
  ], L),

  % Clues.
  \+weapon_at_location(greenskeepers_chainsaw, mens_lounge, L),
  hair(TennisCourtPerson, brown), suspect_at_location(TennisCourtPerson, tennis_court, L),
  statements_liar([
    statement(uncle_midnight, weapon_at_location(poisoned_cocktail, caddy_shack, L)),
    statement(silverton_the_legend, suspect_at_location(silverton_the_legend, caddy_shack, L)),
    statement(judge_pine, suspect_had_weapon(judge_pine, bottle_of_wine, L))
  ], Liar)
.

murdler(Liar, W, L) :-
  solution(S, Liar),
  member([Liar, W, L], S)
.
