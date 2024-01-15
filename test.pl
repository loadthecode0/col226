
/*  del(X,L1,L2) -- delete element X from a list L1 to obtain L2 */ 

del(X, [ ] , [ ]) :- !.
del(X, [X|R], Z) :- del(X, R, Z), !.
del(X, [Y|R], [Y|Z]) :- del(X, R, Z), !.

/*  remdups(L, L1) remove duplicates from a list L to get L1 */

remdups([ ], [ ]) :- !.
remdups([X|R], [X|Z]) :- del(X, R, L), remdups(L, Z).


/* membership of X in S */
/* no element is a member of the empty set */
mem(X,[]) :- fail.
/* X is a member of a set containing X, of course! */
mem(X,[X|_]) :- !.
/* if X is not the first chosen element of S,
then it may be a later element */
mem(X,[_|R]) :- mem(X,R). 


/* Assuming no duplicates in S1, S2

 here is an implementation of union of S1, S2 */

unionI([ ], S2, S2) :- !.
unionI(S1, [ ], S1) :- !.
unionI([X|R], S2, [X|Z]) :- del(X, S2, S3),  unionI(R, S3, Z).



/* append(L1, L2, L3) -- append lis  L1 to list L2 to get list  L3 */

append( [ ], L, L).
append( [X|R], L, [X|Z]) :- append(R, L, Z).



/* mapcons(X,L1, L2) --  cons the element X to each list in L1 to get L2 */

mapcons(X, [ ], [ ]) :- !.
mapcons(X, [Y|R], [ [X|Y] | Z ]) :- mapcons(X, R, Z).



/* powerI( S, P1): Here is an implementation of powerset of S */

powerI([ ], [ [ ] ]) :- !.
powerI([X|R], P) :- powerI(R, P1),  mapcons(X, P1, P2), append(P2, P1, P).


/*-----------my try */

interI([ ], S2, [ ]) :- !.
interI(S1, [ ], [ ]) :- !.
% interI([X|R], [X|L], [X|Z]) :- del(X, R, R1), del(X, L, L1), interI(R1, L1, Z).
% interI([X|R], S2, S3) :- mem(X, S2), del(X, S2, S2_), del(X, R, R1), interI(R1, S2_, S3).
% interI(S1, [X|L], S3) :- mem(X, S1), del(X, S1, S1_), del(X, L, L1), interI(S1_, L1, S3).
interI([X|R], S2, [X|S3]) :- mem(X, S2), interI(R, S2, S3). %if X is a member of Z, put it in S3.
interI([X|R], S2, S3) :- \+mem(X, S2), interI(R, S2, S3). %if X is not a member of Z, don't put it in S3.


diffI(S1, [], S1) :- !.
diffI([], S2, []) :- !.
diffI([X|R], S2, [X|S3]) :- \+mem(X, S2), diffI(R, S2, S3).
diffI([X|R], S2, S3):- mem(X, S2), diffI(R, S2, S3).

%create list of lists combining one element with elements of another list
makelistsI(X, [], []) :- !.
makelistsI(X, [L1|R1], [L2|R2]) :- append([L1], X, L2), makelistsI(X, R1, R2).


% now Cartesian product
cartutil([], S2, []) :- !.
cartutil([X|L], S2, S3) :- mapcons(X, S2, S2_), cartutil(L, S2, V), append(S2_, V, S3).

cartesianI(S1, [], []) :- !.
cartesianI([], S2, []) :- !.
% cartesianI([X|L], S2, S3) :- makelistsI(X, S2, S2_), append([[S2_]], S3, S3_), cartesianI(L, S2, S3_).
% cartesianI([X], S)