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

%atom( A ) :- A =:= [A].

% seq( RE1, RE2 ) :-

% alt( RE1, RE2 ) :-

%star( RE, [L] ) :-

% re_match( RE, ATOM, LST ) :-


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Binary Tree functions.
%
% Conventions: 
%
%       - LBT: The left arm of a binary tree.
%       - E: The element of a binary tree node. 
%       - RBT: The right arm of a binary tree.
%       - LEAF: signifies a leaf of the tree.


% Clause: btree_to_list
%
% Base case, if we have that leaf return a empty list baby!
btree_to_list( leaf, [] ). 

% Clause: btree_to_list
%
% Main clause to convert a Binary Tree to a list.
% We recursively traverse the left side of a tree until we get to a leaf.
% If we reach a leaf we append the node value to the lists all the way up
% to the root. We then append the left list to the root value. After the
% traversal of the entire right side of the tree is complete, we append
% to the head element the left arm of the list. The right side is then
% appended to the result of the previous append. This gives us the final list.
btree_to_list( node( LBT, E, RBT ), FLS ) :- btree_to_list( LBT, LL ), 
                                             btree_to_list( RBT, RL ), 
                                             append( LL, [E], LLF),
                                             append( LLF, RL, FLS).
 
% Clause: btree_depth
%
% Detect if the recursive btree_depth is a leaf, if so the depth is 0.
btree_depth( leaf, N ) :- N is 0.

% Clause: btree_depth
%
% Traverse the left branch, traverse the right and add the total together.
btree_depth( node( LBT, _, RBT ), N ) :- btree_depth( LBT, LN ),
                                         btree_depth( RBT, RN ),
                                         N is LN + RN.

% btree_iso( BT1, BT2 ) :-

% btree_subtree( BT1, BT2 ) :-
