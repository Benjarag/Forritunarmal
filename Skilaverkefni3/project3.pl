% In the following projects, you are NOT allowed to use built-in relations unless it is
% specifically stated.
% skjalið inniheldur skilgreiningar á öllum Prolog venslunum.




%%%%%%%%%
%%% 1 %%%
%%%%%%%%%

% In a particular computer science department, the list of teachers and
% courses is as follows:
% Instructor Course Abbreviation
% hrafn Programming Languages prla
% yngvi Compilers comp
% yngvi Deep Learning deep
% harpa Discrete Mathematics dmath
% stephan Artificial Intelligence ai
% marta Software Requirements and
% Design
% srd
% luca Discrete Mathematics 2 dmath2
% bjorn Database Systems dbase
% kari Programming prog
% kari Computer Graphics cgra
% gylfi Computer Organization corg
% arnar Programming in C++ cplus

% The following table lists all the students in the department along with the
% courses which the students have taken:

% Student prla comp deep dmath ai srd dmath2 dbase prog cgra corg cplus
% siggi    x    x    x     x                             x
% joi                x         x        x                     x
% gummi                    x                   x    x               x
% sigga         x                  x                     x
% gunna    x    x    x                  x                     x     x
% jona     x               x       x           x                    x

% Write the following
% relations using the above information (use teacher’s names, student’s names and the
% course abbreviations as atoms):


%% teaches_course(X,Y) % Instructor X teaches course Y (a fact)
%% takes_course(X,Y) % Student X takes course Y (a fact)
%% teaches_student(X,Y) % Instructor X teaches student Y (a rule)
%% student(X) % X is a student at the department (a rule)
%% takes_courses(X,L) % Student X takes all courses in list L (a rule)
%% student_list(L) % L is a list of students (a rule)

% Teacher course facts
teaches_course(hrafn, prla).
teaches_course(yngvi, comp).
teaches_course(yngvi, deep).
teaches_course(harpa, dmath).
teaches_course(stephan, ai).
teaches_course(marta, srd).
teaches_course(luca, dmath2).
teaches_course(bjorn, dbase).
teaches_course(kari, prog).
teaches_course(kari, cgra).
teaches_course(gylfi, corg).
teaches_course(arnar, cplus).

% Student course facts
takes_course(siggi, prla).
takes_course(siggi, comp).
takes_course(siggi, deep).
takes_course(siggi, dmath).
takes_course(siggi, cgra).

takes_course(joi, deep).
takes_course(joi, ai).
takes_course(joi, dmath2).
takes_course(joi, corg).

takes_course(gummi, dmath).
takes_course(gummi, dbase).
takes_course(gummi, prog).
takes_course(gummi, cplus).

takes_course(sigga, comp).
takes_course(sigga, srd).
takes_course(sigga, cgra).

takes_course(gunna, prla).
takes_course(gunna, comp).
takes_course(gunna, deep).
takes_course(gunna, dmath2).
takes_course(gunna, corg).
takes_course(gunna, cplus).

takes_course(jona, prla).
takes_course(jona, dmath).
takes_course(jona, srd).
takes_course(jona, dbase).
takes_course(jona, cplus).


% A teacher X teaches a student Y, if the student takes a course taught by the teacher
teaches_student(X,Y) :- takes_course(Y, Z), teaches_course(X, Z).

% X is a student if they take at least one course
student(X) :- takes_course(X, _).

% Student X takes all courses in list L
takes_courses(X, []) :- student(X).
takes_courses(X, [H | T]) :- takes_course(X, H), takes_courses(X, T).

% Get a list of all students
% here we use findall to get a list of all students, 
% then we use list_to_set to remove duplicates
student_list(L) :- findall(X, student(X), S), list_to_set(S, L).



%%%%%%%%%
%%% 2 %%%
%%%%%%%%%

% Write the following relations:

% myprefix(L1,L2) % The list L1 is a prefix of the list L2.
myprefix([],_).
myprefix([H|T1],[H|T2]) :- myprefix(T1,T2).

% Examples: 
% ?- myprefix(X,[1,2,3]). 
% X = [] ; 
% X = [1] ; 
% X = [1, 2] ; 
% X = [1, 2, 3] ; 
% false. 
% ?- myprefix([1,2],X). 
% X = [1, 2|_].


% num_elements(K,L)  % K is the number of elements in  list L. 

num_elements(0,[]).
num_elements(K, [H|T]) :- num_elements(K1, T), K is K1 + 1.

% Examples: 
% ?- num_elements(3,[1,2,3]). 
% true. 
% ?- num_elements(X,[a,b,c,d]). 
% X=4.


% remove_element(X,L1,L2)  
% The list L2 is the result of removing exactly one instance of the element X from the list L1.

remove_element(X,[X|T],T).
remove_element(X,[H|T],[H|L]) :- remove_element(X,T,L).

% Examples: 
% ?- remove_element(2,[1,2,2,3],L). 
% L = [1, 2, 3] ; 
% L = [1, 2, 3] ; 
% false. 
% ?- remove_element(X,[1,2,2,3],[1,2,3]). 
% X = 2 ; 
% X = 2 ; 
% false. 
% ?- remove_element(2,L,[1,2,3]). 
% L = [2, 1, 2, 3] ; 
% L = [1, 2, 2, 3] ; 
% L = [1, 2, 2, 3] ; 
% L = [1, 2, 3, 2] ;  
% false. 
% ?- remove_element(X,[1,2,3],L). 
% X=1,  L=[2,3]; 
% X=2,  L=[1,3]; 
% X=3,  L=[1,2];  
% false. 
% ?- remove_element(X,[a,b,c,a],L). 
% X = a, L = [b, c, a] ; 
% X = b, L = [a, c, a] ; 
% X = c, L = [a, b, a] ; 
% X = a, L = [a, b, c] ;  
% false.


% insert_element(Elem,L1,Pos,L2) 
% The list L2 is the result of putting element Elem into the list L1 in position Pos.

insert_element(Elem,L1,1,[Elem|L1]).
% if Pos is greater than 1, then we recursively call insert_element with Pos-1
insert_element(Elem,[H|L1],Pos,[H|L2]) :- insert_element(Elem,L1,NewPos,L2), Pos is NewPos + 1. 

% Examples:
% ?- insert_element(a,[b,c,d],1,[a,b,c,d]). 
% true. 
% ?- insert_element(X,[1,3,4],2,[1,2,3,4]). 
% X = 2 .  
% ?- insert_element(c,[a,b,d],3,L). 
% L = [a, b, c, d] . 
% ?- insert_element(c,[a,b,d],X,[a,b,c,d]).  
% X = 3 .


% add_up_to(L1,L2)
% L2 is a list of integers in which each element is the sum of the elements 
% in list L2 upto the same position. Here, L1 is bound, i.e. the value of L1 is 
% known when a query is made.  

% Hint: Use the helper relation add_up_to_helper(L1,L2,Acc), 
% where Acc (accumulator) is the value that should be added to the head 
% element of L1 to produce the element of L2 at the current position in the 
% recursion.

add_up_to_helper([], [], _).
add_up_to_helper([H1|T1],[H2|T2],Acc) :- H2 is H1 + Acc, add_up_to_helper(T1,T2,H2).

add_up_to(L1, L2) :- add_up_to_helper(L1, L2, 0).

% Examples: 
% ?- add_up_to([1,2,3,4],[1,3,6,10]). 
% true. 
% ?- add_up_to([1,2,3,4],[1,2,6,10]). 
% false. 
% ?- add_up_to([1,3,5,7],L). 
% L = [1,4,9,16].


% remove_duplicates(L1,L2)
% The list L2 contains only unique elements from L1  
% The last instance of repeated elements is kept in L2. 
% Here you can use the built-in member(X,L) predicate to check if an element X is in the list L. 
% L1 is bound when a query is made.

remove_duplicates([],[]). % empty list becomes empty list
remove_duplicates([H1|T1],L2) :- member(H1,T1), remove_duplicates(T1,L2).
% H makes it into the list now because we are doing for the same H: [H|T1] and [H|T2]
remove_duplicates([H|T1],[H|T2]) :- \+ member(H,T1), remove_duplicates(T1,T2). 

% Examples:
% ?- remove_duplicates([a, b, a, c, b, d], X). 
% X = [a, c, b, d] .


% split_even_odd(L, Even, Odd)
% Even is a list containg elements at even indices in list L and Odd is a list 
% containing elements at odd indices in list L.  The first item in list L is at index 0.

split_even_odd([],[],[]).
split_even_odd(L,Even,Odd) :- split_even(L,Even,Odd).
split_even([],[],[]).
split_odd([],[],[]).
split_even([H|T],[H|Even],Odd) :- split_odd(T,Even,Odd).
split_odd([H|T],Even,[H|Odd]) :- split_even(T,Even,Odd).

% Examples: 
% ?- split_even_odd([a, b, c, d, e], Even, Odd). 
% Even = [a, c, e], Odd = [b, d] . 
% ?- split_even_odd(X, [1, 2, 3], [4, 5]). 
% X = [1, 4, 2, 5, 3] .


% merge_sorted(L1, L2, L3)
% L3 is the (sorted) results of merging the two sorted lists L1 and L2.  
% Both L1 and L2 are bound when a query is made 

merge_sorted([],L2,L2).
merge_sorted(L1,[],L1).
merge_sorted([H1|T1],[H2|T2],[H1|T3]) :- H1 =< H2, merge_sorted(T1,[H2|T2],T3).
merge_sorted([H1|T1],[H2|T2],[H2|T3]) :- H1 > H2, merge_sorted([H1|T1],T2,T3).

% Example: 
% ?- merge_sorted([1, 3, 5], [2, 4, 6], X). 
% X = [1, 2, 3, 4, 5, 6] .



%%%%%%%%%
%%% 3 %%%
%%%%%%%%%

% a) Stack
% implement a stack in Prolog (by using lists) which consists of the following relations:

% empty_stack(S)
% S is an empty stack

empty_stack([]).

% push(Elem,Stack,NewStack)
% NewStack is the result of pushing Elem onto the stack Stack.

push(Elem,Stack,[Elem|Stack]).

% pop(Elem, Stack, NewStack)
% NewStack is the result of popping Elem from the stack Stack.

pop(Elem,[Elem|T],T).

% top(Elem, Stack)
% Elem is the top element of the stack Stack.

top(Elem,[Elem|Stack]).

% Example:
% ?- empty_stack(S), push(10, S, S1), push(20, S1, S2), pop(X, S2, S3), top(Top, S3).
% S = [],
% S1 = S3, S3 = [10],
% S2 = [20, 10],
% X = 20,
% Top = 10.


% b) Queue
% implement a queue in Prolog (by using lists) which consists of the following relations:

% empty_queue(S)
% S is an empty queue

empty_queue([]).

% enqueue(Elem, Queue, NewQueue)
% NewQueue is the result of adding Elem at the back of queue Queue.

enqueue(Elem,[],[Elem]).
enqueue(Elem,[H|TQ],[H|TNQ]) :- enqueue(Elem,TQ,TNQ).

% dequeue(Elem, Queue, NewQueue)
% NewQueue is the result of removing Elem from the front of queue Queue.

dequeue(Elem,[Elem|T],T).

% front(Elem, Queue)
% Elem is the front elment of queue Queue.

front(Elem,[Elem|Queue]).

% Example:
% ?- empty_queue(Q), enqueue(5, Q, Q1), enqueue(7, Q1, Q2), dequeue(X, Q2, Q3), front(First, Q3).
% Q = [],
% Q1 = [5],
% Q2 = [5, 7],
% X = 5,
% Q3 = [7],
% First = 7.



%%%%%%%%%
%%% 4 %%%
%%%%%%%%%

% Parsing

% The following CFG is given:

% <expr> ::= <term> | <term> + <expr>
% <term> ::= <factor> | <factor> * <term>
% <factor> ::= <num> | ( <expr> )

% Let us assume that a string in this language is represented as a list of numbers
% and symbols.
% Example: The expression 5*(2+7) is represented as the list [5, *, '(', 2, +, 7, ')']

% Write the relation expr(L) (and other necessary relations) such that L is a valid
% expression according to the grammar. Here you can use the append and number relations.

% <expr> ::= <term> | <term> + <expr>
expr(Input|Remaining) :- term(Input,Remaining).
expr(Input,Remaining) :- append(term(Input,Remaining),expr(Input,Remaining)).

% <term> ::= <factor> | <factor> * <term>
term(Input,Remaining) :- factor(Input,Remaining) 
term(Input,Remaining) :- factor(L) * term(L).

% <factor> ::= <num> | ( <expr> )
factor([H|TInput],Remaining) :- number(H).

factor(Input,Remaining) :- expr(Input,Remaining).

% Examples:
% ?- expr([5]).
% true.
% ?- expr([5,+,2]).
% true.
% ?- expr([5,+]).
% false.
% ?- expr([5, *, '(', 2, +, 7, ')']).
% true.

