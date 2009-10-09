% PLC Lab #2 
% Author: Brian Gianforcaro 
% Tested and developed GNU Prolog v1.3.1


% Clause: split_two
%
% Specification:
% -------------
% Split any two lists apart as equally as possible.
%
% Description:
% ------------
% Split base case, can't split an empty list.

split_two( [], [], [] ).

% Description:
% ------------
% Split a list with a single element, 
% first is a that list, second is empty list.

split_two( [L], [], [L] ).

% Description:
% ------------
% Do the actual work to split to two lists into two sections.
% Use append() to give us two lists which would create the input list.
% Then find the length of the two halves, If the length's differ by one or zero
% then the list is reasonably split in half X and Y. Cut after we get the first result.

split_two( IN, X, Y ):- append( X, Y, IN ),
                        length( X, LENX ), length( Y, LENY ),
                        ( 1 =:= abs( LENY - LENX ) ; 0 =:= LENY - LENX ), !.

% Clause: merge_two
%
% Specification:
% --------------
% Merge two small seperate lists togeather, in smallest to largest ordering.
%
% Description: 
% ------------
% Base cases, merge any empty list with a non
% empty list by just returning the non empty list. 
% Easy peasy.

merge_two( [], L, L ).

% Description:
% ------------
% Reverse base cases of the above, merge any
% empty list with a non empty list by just returning the non empty.

merge_two( L, [], L ).

% Description:
% ------------
% If the Head of list one is less than or equal to the head of list two, 
% recursively merge the tail of list one with the entirety of list two. 
% Combining head of list one with the resultant merged lists.

merge_two( [H1 | T1], [H2 | T2], [H1 | MERG] ):- H1 =< H2, 
                                              merge_two( T1, [H2 | T2], MERG).

% Description:
% ------------
% If the Head of list one is greater than the head of list two, 
% recursively merge the entirety of list one with the tail of list two. 
% Finally combine The head of list two with the resultant merged lists.

merge_two( [H1 | T1], [H2 | T2], [H2 | MERG] ):- H1 > H2, 
                                              merge_two( [H1 | T1], T2, MERG).

% Clause: int_mergesort
%
% Specification:
% --------------
% Split the list in half recursively, once at the lowest point merge back each
% part in smallest to largest order. Finally combining both of the original halves.
% 
% Description:
% ------------
% Merge sort base case #2 when we have a empty list, return empty.

int_mergesort( [], [] ).

% Description:
% ------------
% Merge sort base cases when we have a one element list, just return it.

int_mergesort( [ONE], [ONE] ).

% Description:
% ------------
% Run the actual merge sort, LS is the input list, FL is the final sorted list.

int_mergesort( [ONE,TWO | TAIL], FL ) :- split_two( [ONE,TWO | TAIL], L1, L2 ),
                                         int_mergesort( L1, SORTED1 ),
                                         int_mergesort( L2, SORTED2 ),
                                         merge_two( SORTED1, SORTED2, FL ),!.

% Some of my test cases:
%
% int_mergesort( [5,4,3,2,1], L ).
%
% int_mergesort( [1,2,3,5,2], L ).
%
% int_mergesort( [9,8,6,5,3,2], L ).
%
% int_mergesort( [1,2,3], L ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Regular Expression Operations

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
% Description:
% ------------
% Base case, if we have that leaf return a empty list baby!

btree_to_list( leaf, [] ).

% Description: 
% ------------
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
% Specification:
% --------------
% Satisfied when the second integer parameter corresponds to the depth of 
% the first binary-tree parameter. A leaf binary tree has depth zero, while
% a node binary tree has depth one greater than the maximum of the depths of
% its immediate sub-trees.
%
% Description:
% ------------
% Detect if the recursive btree_depth is a leaf, if so the depth is 0.

btree_depth( leaf, N ) :- N is 0.

% Description:
% ------------
% Traverse the left branch, traverse the right and add the total together.

btree_depth( node( LBT, _, RBT ), N ) :- btree_depth( LBT, LN ),
                                         btree_depth( RBT, RN ),
                                         N is LN + RN.

% Clause: btree_iso
%
% Specification:
% --------------
% Satisfied when the two binary-tree parameters are isomorphic. Two binary 
% trees are isomorphic if one can be derived from the other by changing the
% order of the branches. Either of the parameters may be instantiated with a
% variable when btree_iso is used in a top-level goal.
%
% Description:
% ------------
%
% btree_iso( BT1, BT2 ) :-

% Clause: btree_subtree
%
% Specification: 
% --------------
% Satisfied when the second binary-tree parameter is a sub-tree 
% (not necessarily an immediate sub-tree) of the first binary-tree parameter. 
% Either of the parameters may be instantiated with a variable when 
% btree_subtree is used in a top-level goal.
%
% Description:
% ------------


% btree_subtree( BT1, BT2 ) :-
