% PLC Lab #2 
% Author: Brian Gianforcaro 
% Tested and developed GNU Prolog v1.3.1


% Clause: split_two
% Description: Split base case, can't split an empty list.
split_two( [], [], [] ).

% Clause: split_two
%
% Description:
%
% Split a list with a single element, 
% first is a that list, second is empty list.

split_two( [L], [L], [] ).

% Clause: split_two
%
% Description:
%
% Do the actual work to split to two lists into two sections.
% Use append() to give us two lists which would create the input list.
% Then find the length of the two halves, If the length's differ by one or zero
% then the list is reasonably split in half X and Y.

split_two( IN, X, Y ):- append( X, Y, IN ),
                        length( X, LENX ), length( Y, LENY ), 
                        ( 1 =:= abs( LENY - LENX ) ; 0 =:= LENY - LENX ).

% Clause: merge_two
%
% Description: 
% Base cases, merge any empty list with a non
% empty list by just returning the non empty.

merge_two( [], L, L ).

% Clause: merge_two
%
% Description:
% Reverse base cases of the above, merge any
% empty list with a non empty list by just returning the non empty.

merge_two( L, [], L ).

% Clause: merge_two 
%
% Description:
% If the Head of list one is less than or equal to the head of list two, 
% recursively   merge the tail of list one with the entirety of list two. 
merge_two( [HL1|TL1], [HL2,TL2], [HL1|MERGED] ) :- HL1 =< HL2,
                                                   merge( TL1, [HL2|TL2], MERGED ).

% Clause: merge_two
% 
% Description:
% If the Head of list one is greater than the head of list two, 
% recursively  merge list one with the tail of list two. 
merge_two( [HL1|TL1], [HL2,TL2], [HL2|MERGED] ) :- HL1 > HL2, 
                                                   merge( [HL1|TL1], TL2, MERGED ).

% Clause: int_mergesort
% 
% Description:
% Merge sort base case #2 when we have a empty list, return empty.
int_mergesort( [], [] ).

% Clause: int_mergesort
%
% Description:
% Merge sort base cases when we have a one element list, just return it.
int_mergesort( [ONE], [ONE] ).

% Clause: int_mergesort
%
% Description:
% Run the actual merge sort, LS is the input list, FL is the final sorted list.
int_mergesort( LS, FL ) :- split( LS, L1, L2 ),
                           mergesort( L1, SORTED1 ),
                           mergesort( L2, SORTED2 ),
                           merge( SORTED1, SORTED2, FL ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

epsilon([]).

atom( A ) :-

seq( REG1, REG2 ) :-

alt( REG1, REG2 ) :-

star( REGEX, [L] ) :-

re_match( REGEX, ATOM, LST ) :-


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leaf( [] ).

node( leaf( [] ) 
node( leaf( [] ) , E, BTR ).

node( BTL, E, leaf( [] ) ).

node( node( LL, LE, LR ), E,  node( RL, RE, RR ) ).

btree_to_list( BT, LS ) :- node(L, E, R) =:= BT, btree_to_list( L, H ), btree_to_list( R, T ), LS is [H|T]. 
 
btree_to_list( BT, LS ) :-

% Detect if the recursive btree_depth is a end point, both arms are leaves.
btree_depth( BT, N ) :- BT =:= node( leaf( [] ),X, leaf( [] ) ), N is 0.

btree_depth( BT, N ) :- BT, btree_depth( BT, NR ), N is NR + 1.

btree_iso( BT1, BT2 ) :-

btree_subtree( BT1, BT2 ) :-
  

