
% PLC Lab #2 
% Author: Brian Gianforcaro 
% Tested and developed GNU Prolog v1.3.1

% Merge sort routines

% Split base case, can't split an empty list.
split_two([],[],[]).
% Split a list with a single element, 
% first is a that list, second is empty list.
split_two([L],[L], []).
% Do the actual work to split to two lists into two sections.
% Use append() to give us two lists which would create the input list.
% Then find the length of the two halves, If the length's differ by one or zero
% then the list is reasonably split in half X and Y.
split_two( IN, X, Y ):- append( X, Y, IN ),
                        length( X, LENX ), length( Y, LENY ), 
                        ( 1 =:= abs( LENY - LENX ) ; 0 =:= LENY - LENX ).

% Base cases, merge any empty list with a non
% empty list by just returning the non empty.
merge_two( [], L, L ).
% Opposite base cases of the above, merge any
% empty list with a non empty list by just returning the non empty.
merge_two( L, [], L ).

% If the Head of list one is less than or equal to the head of list two, 
% recursively   merge the tail of list one with the entirety of list two. 
merge_two( [HL1|TL1], [HL2,TL2], [HL1|MERGED] ) :- HL1 =< HL2,
                                                   merge( TL1, [HL2|TL2], MERGED ).

% If the Head of list one is greater than the head of list two, 
% recursively  merge list one with the tail of list two. 
merge_two( [HL1|TL1], [HL2,TL2], [HL2|MERGED] ) :- HL1 > HL2, 
                                                   merge( [HL1|TL1], TL2, MERGED ).

% Merge sort base case #2 when we have a empty list, return empty.
int_mergesort( [], [] ).
% Merge sort base cases when we have a one element list, just return it.
int_mergesort( [ONE], [ONE] ).
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

node( BTL, E, BTR ) :-

btree_to_list( BT, L ) :-


btree_depth( BT, D ) :- 
btree_depth( BT, D ) :- btree_depth( BT, DR ), D is DR + 1.

btree_iso( BT1, BT2 ) :-

btree_subtree( BT1, BT2 ) :-


