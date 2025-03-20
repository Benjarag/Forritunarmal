% 1. even(L)
% The list L has even number of elements.

even([]).
even([_,_|T]) :- even(T).


% 2. myLast(X,L)
% X is the last element of the list L. Do NOT use the append relation.

myLast(X,[X]).
myLast(X,[_|T]) :- myLast(X, T).


% 3. element(X,L)
% X is an element of the list L

element(X, [X | _]).
element(X, [_ | T]) :- element(X, T).


% 4. allButLast(L1,L2)
% List L2 contains all but the last element of list L1. Make two
% implementations: One using the append relation, the other purely recursive.

% allButLast(L1, L2) :- append(L2, [_], L1).

allButLast([X], []).
allButLast([H | L1], [H | L2]) :- allButLast(L1, L2).


% 5. subset(X,Y)
% Every element of list X occurs in list Y. Uses the element relation.

subset([], _).
subset([H | T], Y) :- element(H, Y), subset(T, Y).


% 6. split(L,N,L1,L2) % This one might be tricky!
% The list L1 contains the first N elements of the list L, the list L2 contains
% the remaining elements

split([], 0, [], []).
split([H | T], 0, [], [H | T]).
split([H | T], N, [H | L1], L2) :- N1 is N - 1, split(T, N1, L1, L2).
