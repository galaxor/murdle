% Reasoning about height.
left_taller(P1, P2) :- 
  height(P1, [F1, I1]), height(P2, [F2, I2]), (F1 > F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 > I2.

same_height(P1, P2) :- height(P1, [F1, I1]), height(P2, [F2, I2]), F1 == F2, I1 == I2, P1 \== P2.

left_shorter(P1, P2) :- 
  height(P1, [F1, I1]), height(P2, [F2, I2]), (F1 < F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 < I2.


tallest([P|[]], P).
tallest([P|[P1|T]], M) :- tallest([P|T], M), left_taller(P, P1); tallest([P|T], M), same_height(P, P1); tallest([P1|T], M), left_shorter(P, P1).


% Biographical Info
% I wonder if this information is always the same for each of these people.
% I'll add to this as each day's clues make the info relevant.  Eventually,
% I'll have a full roster of info on all the people that exist and all the
% weapons that exist.
% I mean, assuming the info isn't randomly generated for each puzzle.

right_handed(president_amaranth).
right_handed(vice_president_mauve).
right_handed(babyface_blue).
right_handed(silverton_the_legend).
left_handed(signor_emerald).
left_handed(mx_tangerine).

height(president_amaranth, [5,10]).
height(vice_president_mauve, [5,8]).
height(babyface_blue, [7,8]).
height(silverton_the_legend, [6,4]).
height(signor_emerald, [5,8]).
height(mx_tangerine, [5,5]).

sign(mx_tangerine, pisces).
sign(sir_rulean, leo).
sign(father_mango, taurus).
sign(agent_fuchsia, virgo).


% Weapon data
medium_weight(bottle).
medium_weight(cake).
light_weight(key).
light_weight(shiv).
light_weight(cufflinks).
heavy_weight(lawyer).
