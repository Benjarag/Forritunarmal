% Implement the following Prolog predicates and test them by presenting queries. Note
% that underscore can be used as a wildcard. For example, the pattern [_] matches a list
% with one element and [_,_] matches a list with two elements. Moreover, the pattern
% [H|T] matches a list with head H and tail L.

% 1. member_greater_than_in_list(X,L,G)
% % The element X is a member of the list L and X is greater than G.
% % Implement this using a guess and verify strategy: Use the built-in member
% relation for the guess part and then verify that the element is greater than G.

member_greater_than_in_list(X,L,G) :- member(X,L), X > G.


% 2. elementAt(X,L,K)
% % X is the K-th element of the list L. We assume K≥1.

elementAt(X,[X|_],1).
elementAt(X,[H|T],K) :- elementAt(X,T,K1), K is K1 + 1. 


% 3. insertElement(X,L1,L2)
% % The list L2 is formed by inserting the element X somewhere into the list L1.

insertElement(X,L1,[X|L1]).
insertElement(X,[H|T1],[H|T2]) :- insertElement(X,T1,T2).


% 4. occurrences(X,L,N)
% % Element X occurs N times in the list L.

occurrences(_,[],0).
occurrences(X,[X|T],N) :- occurrences(X,T,N1), N is N1 + 1.
occurrences(X,[H|T],N) :- occurrences(X,T,N), H\=X.


% 5. compress(L1,L2) % May be difficult!
% % The list L2 is obtained from the list L1 by compressing repeated
% occurrences of the elements of L1 into a single copy.

compress([],[]).
compress([X],[X]).
compress([H,X|T1],[H|T2]) :- compress([X|T1],T2), H\=X.
compress([H,X|T1],[H|T2]) :- compress([X|T1],[H|T2]), H=X.


% 6. number_type(N, T)
% % The number N is of type T where T is in the set {positive, zero, negative}.
% % Use a cut in your solution, such that if a number is found to be positive, no
% further rules are tried, and the same if a number is found to be zero.

number_type(N, positive) :- N > 0, !.
number_type(0, zero) :- !.
number_type(N, negative) :- N < 0, !.

% Examples:
% ?- number_type(5, T).
% T = positive.
% ?- number_type(N, zero).
% N = 0.
% ?- number_type(-3, T).
% T = negative.