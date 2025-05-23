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

% include/3 is in SWI-Prolog, but not in gprolog.
% Define a polyfill here, I guess??
include(_, [], []).
include(Goal, [A|Rest], [A|TrueRest]) :- call(Goal, A), include(Goal, Rest, TrueRest).
include(Goal, [A|Rest], TrueRest) :- \+call(Goal, A), include(Goal, Rest, TrueRest).


% Succeeds if exactly one of the statements is a lie.
one_is_lie(StatementList) :- include(call, StatementList, TrueStatements), 
  length(StatementList, NumStatements), length(TrueStatements, NumTrueStatements),
  NumStatements =:= NumTrueStatements + 1
.

% Statements are of the form: statement(Speaker, TheirClaim).

% Given a list of statements like
%   [statement(coach_raspberry, sky(blue)), statement(dame_obsidian, delicious(soup))],
% L will become just the statement part, with the speaker extracted:
% In the example above, L would be
%   [sky(blue), delicious(soup)].
% The truth of the statements won't be checked.
statements_list([], []).
statements_list([statement(_, Statement)|StatementsWithSpeaker], L) :-
  L=[Statement|FurtherStatements], statements_list(StatementsWithSpeaker, FurtherStatements)
.

% Given a list of statements like
%   [statement(coach_raspberry, sky(blue)), statement(dame_obsidian, delicious(soup))],
% Liar will become the speaker of the single statement that is false.
% For example, if the soup is not, in fact, delicious, then delicious(soup) fails, and Liar=dame_obsidian.
% If there is more than one liar, then the predicate will fail.
% If there are zero liars, then the predicate will fail.
statements_liar([], _) :- false.
statements_liar([statement(Speaker, Statement)|StatementsWithSpeaker], Liar) :-
    % If the first statement is a lie and all the others are true.
  (\+call(Statement),
    statements_list(StatementsWithSpeaker, Statements),
    include(call, Statements, Truths), 
    length(Truths, N), length(Statements, N), Liar=Speaker)
    % If the first statement is true, check the rest.
  ; (call(Statement), statements_liar(StatementsWithSpeaker, Liar))
.

% What birthdays correspond to what signs?
birthday_sign(Month, Day, aries) :- (Month=march, Day >= 21) ; (Month=april, Day =< 19).
birthday_sign(Month, Day, taurus) :- (Month=april, Day >= 20) ; (Month=may, Day =< 20).
birthday_sign(Month, Day, gemini) :- (Month=may, Day >= 21) ; (Month=june, Day =< 20).
birthday_sign(Month, Day, cancer) :- (Month=june, Day >= 21) ; (Month=july, Day =< 22).
birthday_sign(Month, Day, leo) :- (Month=july, Day >= 23) ; (Month=august, Day =< 22).
birthday_sign(Month, Day, virgo) :- (Month=august, Day >= 23) ; (Month=september, Day =< 22).
birthday_sign(Month, Day, libra) :- (Month=september, Day >= 23) ; (Month=october, Day =< 22).
birthday_sign(Month, Day, scorpio) :- (Month=october, Day >= 23) ; (Month=november, Day =< 21).
birthday_sign(Month, Day, sagittarius) :- (Month=november, Day >= 22) ; (Month=december, Day =< 21).
birthday_sign(Month, Day, capricorn) :- (Month=december, Day >= 22) ; (Month=january, Day =< 19).
birthday_sign(Month, Day, aquarius) :- (Month=january, Day >= 20) ; (Month=february, Day =< 18).
birthday_sign(Month, Day, pisces) :- (Month=february, Day >= 19) ; (Month=march, Day =< 20).


% Biographical Info
dossier(secretary_celadon,
  height(5,6),
  handed(left),
  eyes(green),
  hair(brown),
  sign(leo)
).

dossier(principal_applegreen,
  height(5,11),
  handed(right),
  eyes(blue),
  hair(none),
  sign(libra)
).

dossier(grandmaster_rose,
  height(5,7),
  handed(left),
  eyes(brown),
  hair(brown),
  sign(scorpio)
).

dossier(signor_emerald,
  height(5,8),
  handed(left),
  eyes(brown),
  hair(black),
  sign(sagittarius)
).

dossier(officer_copper,
  height(5,5),
  handed(right),
  eyes(blue),
  hair(blond),
  sign(aries)
).

left_handed(Person) :- dossier(Person, height(_,_), handed(left), eyes(_), hair(_), sign(_)).
left_handed(amazing_aureolin).
left_handed(major_red).
left_handed(mx_tangerine).

right_handed(Person) :- dossier(Person, height(_,_), handed(right), eyes(_), hair(_), sign(_)).
right_handed(babyface_blue).
right_handed(lady_violet).
right_handed(president_amaranth).
right_handed(silverton_the_legend).
right_handed(vice_president_mauve).

height(Person, [Feet, Inches]) :- dossier(Person, height(Feet, Inches), handed(_), eyes(_), hair(_), sign(_)).
height(babyface_blue, [7,8]).
height(brother_brownstone, [5,4]).
height(coach_raspberry, [6,0]).
height(deacon_verdigris, [5,3]).
height(dr_crimson, [5,9]).
height(earl_grey, [5,9]).
height(lady_violet, [5,0]).
height(mayor_honey, [6,0]).
height(miss_saffron, [5,2]).
height(mx_tangerine, [5,5]).
height(president_amaranth, [5,10]).
height(silverton_the_legend, [6,4]).
height(sister_lapis, [5,2]).
height(uncle_midnight, [5,8]).
height(vice_president_mauve, [5,8]).

sign(Person, Sign) :- dossier(Person, height(_,_), handed(_), eyes(_), hair(_), sign(Sign)).
sign(agent_fuchsia, virgo).
sign(brother_brownstone, capricorn).
sign(dame_obsidian, leo).
sign(deacon_verdigris, leo).
sign(dean_glaucous, virgo).
sign(dr_crimson, aquarius).
sign(earl_grey, capricorn).
sign(father_mango, taurus).
sign(general_coffee, sagittarius).
sign(lady_violet, virgo).
sign(lord_lavendar, virgo).
sign(mayor_honey, scorpio).
sign(miss_ruby, libra).
sign(mx_tangerine, pisces).
sign(secretary_celadon, leo).
sign(sir_rulean, leo).
sign(vice_president_mauve, taurus).


eyes(Person, Color) :- dossier(Person, height(_,_), handed(_), eyes(Color), hair(_), sign(_)).
eyes(agent_fuchsia, brown).
eyes(amazing_aureolin, green).
eyes(baron_maroon, hazel).
eyes(bishop_azure, brown).
eyes(brother_brownstone, brown).
eyes(captain_slate, brown).
eyes(chancellor_tuscany, green).
eyes(coach_raspberry, blue).
eyes(deacon_verdigris, blue).
eyes(dean_glaucous, brown).
eyes(dr_crimson, green).
eyes(earl_grey, brown).
eyes(father_mango, brown).
eyes(lady_violet, blue).
eyes(lord_lavendar, green).
eyes(major_red, brown).
eyes(mayor_honey, hazel).
eyes(miss_ruby, green).
eyes(miss_saffron, hazel).
eyes(mx_tangerine, hazel).
eyes(president_amaranth, grey).
eyes(silverton_the_legend, blue).
eyes(sister_lapis, brown).
eyes(uncle_midnight, blue).
eyes(vice_president_mauve, brown).
eyes(viscount_eminence, grey).

hair(Person, Color) :- dossier(Person, height(_,_), handed(_), eyes(_), hair(Color), sign(_)).
hair(bishop_azure, brown).
hair(brother_brownstone, brown).
hair(coach_raspberry, blond).
hair(deacon_verdigris, grey).
hair(dr_crimson, red).
hair(lady_violet, blond).
hair(mayor_honey, brown).
hair(miss_ruby, red).
hair(miss_saffron, blond).
hair(mx_tangerine, blond).
hair(silverton_the_legend, silver).
hair(sister_lapis, brown).
hair(uncle_midnight, brown).


% Weapon data
weapon_composition(walking_stick, 
  weight(medium),
  made_of([metal])
).
weapon_composition(climbing_rope,
  weight(light),
  made_of([fiber])
).
weapon_composition(murdle_volume_3,
  weight(medium),
  made_of([paper])
).
weapon_composition(snowglobe,
  weight(medium),
  made_of([metal, glass, water])
).
weapon_composition(laptop,
  weight(medium),
  made_of([metal, plastic])
).

heavy_weight(Weapon) :- weapon_composition(Weapon, weight(heavy), made_of(_)).
heavy_weight(bear_trap).
heavy_weight(crystal_ball).
heavy_weight(golf_cart).
heavy_weight(hammer_and_sickle).
heavy_weight(heavy_painting).
heavy_weight(lawyer).
heavy_weight(oar).
heavy_weight(old_heavy_tome).
heavy_weight(rare_vase).
heavy_weight(stage_light).

light_weight(Weapon) :- weapon_composition(Weapon, weight(light), made_of(_)).
light_weight(ancient_plague).
light_weight(crazed_squirrel).
light_weight(cufflinks).
light_weight(glass_of_wine).
light_weight(gloves).
light_weight(key).
light_weight(poisoned_tea).
light_weight(shiv).

medium_weight(Weapon) :- weapon_composition(Weapon, weight(medium), made_of(_)).
medium_weight(award).
medium_weight(axe).
medium_weight(bottle).
medium_weight(cake).
medium_weight(camera).
medium_weight(clapboard).
medium_weight(dagger).
medium_weight(golden_handcuffs).
medium_weight(gold_watch).
medium_weight(ordinary_brick).
medium_weight(poisoned_goblet).
medium_weight(rope_of_clothes).

made_of(Weapon, Substance) :- weapon_composition(Weapon, weight(_), made_of(Substances)), member(Substance, Substances).
made_of(ancient_anchor, metal).
made_of(award, metal).
made_of(axe, metal).
made_of(axe, wood).
made_of(bear_trap, metal).
made_of(boiling_pot, metal).
made_of(boiling_pot, water).
made_of(brick_of_coal, rock).
made_of(brick, clay).
made_of(camera, glass).
made_of(camera, metal).
made_of(camera, plastic).
made_of(clapboard, wood).
made_of(climbing_axe, metal).
made_of(climbing_axe, wood).
made_of(corgi_stampede, corgis).
made_of(glass_of_wine, alcohol).
made_of(glass_of_wine, chemicals).
made_of(glass_of_wine, glass).
made_of(golf_cart, metal).
made_of(golf_cart, plastic).
made_of(golf_cart, rubber).
made_of(hammer_and_sickle, metal).
made_of(heavy_painting, canvas).
made_of(heavy_painting, paint).
made_of(heavy_painting, wood).
made_of(holy_relic, bone).
made_of(italian_knife, leather).
made_of(italian_knife, metal).
made_of(karate_hands, hands).
made_of(metal_straw, metal).
made_of(metal_straw, wood).
made_of(oar, wood).
made_of(ordinary_brick, brick).
made_of(poisoned_champagne, glass).
made_of(poisoned_champagne, toxins).
made_of(poisoned_tea, ceramic).
made_of(poisoned_tea, liquid).
made_of(rare_vase, ceramic).
made_of(stage_light, glass).
made_of(stage_light, metal).
made_of(steering_wheel, wood).
made_of(venemous_spider, live_animal).
made_of(wine, glass).
made_of(yarn, wool).

% Location data
indoors(locked_stage).
indoors(mysterious_mansion).
indoors(observatory).
indoors(watertower_bar_grill).
outdoors(ancient_ruins).
outdoors(city_backlot).
outdoors(cliffs).
outdoors(docks).
outdoors(entrance_gate).
outdoors(haunted_grove).
outdoors(hedge_maze).
outdoors(minigolf_course).
outdoors(statue_of_midnight).
