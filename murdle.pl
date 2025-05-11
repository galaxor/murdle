% Reasoning about height.
left_taller(P1, P2) :- 
  height(P1, [F1, _]), height(P2, [F2, _]), (F1 > F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 > I2.

same_height(P1, P2) :- height(P1, [F1, I1]), height(P2, [F2, I2]), F1 == F2, I1 == I2, P1 \== P2.

left_shorter(P1, P2) :- 
  height(P1, [F1, _]), height(P2, [F2, _]), (F1 < F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 < I2.

shortest([P|[]], P).
shortest([P|[P1|T]], M) :- left_shorter(P, P1), shortest([P|T], M); same_height(P, P1), shortest([P|T], M); left_taller(P, P1), shortest([P1|T], M).

tallest([P|[]], P).
tallest([P|[P1|T]], M) :- left_taller(P, P1), tallest([P|T], M); same_height(P, P1), tallest([P|T], M); left_shorter(P, P1), tallest([P1|T], M).

second_tallest(People, Person) :- 
  findall(H, (member(P, People), height(P, H)), Heights),
  sort(Heights, SortedHeights),
  nth(2, SortedHeights, SecondHeight),
  member(Person, People),
  height(Person, SecondHeight)
.

% Some rules for "one of these is a lie".
% I typed this into the repl, and I got that L = [e].
%    findall(X, (X=e, \+member(X, [a,b,c])), L).
% This could be used if a person says "Mx Tangerine was not at the clubhouse",
% and we can put that and some other assertions in like this:
%    findall(X1, (X1=principal_applegreen, member(X1, [a, b, c], L2).
% So that creates lists L and L2 that may have a thing in them, but we don't
% have to find a situation where all of the statements are true.
% Then we say 
%    length(L, N), length(L2, N2), 1 =:= N + N2.
% Which should give us "one of these two things is true".


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

height(babyface_blue, [7,8]).
height(deacon_verdigris, [5,3]).
height(dr_crimson, [5,9]).
height(earl_grey, [5,9]).
height(lady_violet, [5,0]).
height(mayor_honey, [6,0]).
height(miss_saffron, [5,2]).
height(mx_tangerine, [5,5]).
height(president_amaranth, [5,10]).
height(principal_applegreen, [5,11]).
height(secretary_celadon, [5,6]).
height(signor_emerald, [5,8]).
height(silverton_the_legend, [6,4]).
height(sister_lapis, [5,2]).
height(vice_president_mauve, [5,8]).

sign(agent_fuchsia, virgo).
sign(deacon_verdigris, leo).
sign(earl_grey, capricorn).
sign(father_mango, taurus).
sign(lady_violet, virgo).
sign(mayor_honey, scorpio).
sign(mx_tangerine, pisces).
sign(sir_rulean, leo).

eyes(bishop_azure, brown).
eyes(brother_brownstone, brown).
eyes(captain_slate, brown).
eyes(coach_raspberry, blue).
eyes(deacon_verdigris, blue).
eyes(dr_crimson, green).
eyes(earl_grey, brown).
eyes(lady_violet, blue).
eyes(mayor_honey, hazel).
eyes(miss_ruby, green).
eyes(miss_saffron, hazel).
eyes(president_amaranth, grey).
eyes(secretary_celadon, green).
eyes(sister_lapis, brown).

hair(bishop_azure, brown).
hair(brother_brownstone, brown).
hair(dr_crimson, red).
hair(lady_violet, blond).
hair(miss_ruby, red).
hair(mx_tangerine, blond).
hair(principal_applegreen, none).
hair(secretary_celadon, brown).
hair(sister_lapis, brown).


% Weapon data
heavy_weight(crystal_ball).
heavy_weight(golf_cart).
heavy_weight(lawyer).
heavy_weight(stage_light).
light_weight(cufflinks).
light_weight(gloves).
light_weight(key).
light_weight(shiv).
medium_weight(award).
medium_weight(bottle).
medium_weight(cake).
medium_weight(camera).
medium_weight(clapboard).
medium_weight(dagger).

made_of(award, metal).
made_of(camera, glass).
made_of(camera, metal).
made_of(camera, plastic).
made_of(clapboard, wood).
made_of(golf_cart, metal).
made_of(golf_cart, plastic).
made_of(golf_cart, rubber).
made_of(stage_light, glass).
made_of(stage_light, metal).


% Location data
indoors(locked_stage).
indoors(observatory).
indoors(watertower_bar_grill).
outdoors(city_backlot).
outdoors(entrance_gate).
outdoors(hedge_maze).
outdoors(minigolf_course).
outdoors(statue_of_midnight).
