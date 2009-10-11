% PLC Lab #2
% Author: Brian Gianforcaro
% Tested and developed GNU Prolog v1.3.1 & SWI-PL v5.6.62


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

int_mergesort( [ONE, TWO | TAIL], FL ) :- split_two( [ONE, TWO | TAIL], L1, L2 ),
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

% Conventions:
%
%
%  epsilon:
%  --------
%  (Data Structure) epsilon represents the regular expression that matches
%  the empty list.
%
%  atom( A ):
%  ----------
%  (Data Structure) Represents the regular expression that matches the
%  singleton list containing the atom A.
%


% Clause: seq
%
% Specification:
% --------------
% (Data Structure) Represents the regular expression that matches any list that
% can split into two lists (such that appending the two lists yields the
% original list) where the regular expression RE1  matches the first list
% and the regular expression RE2  matches the second list.
%
% Description:
% ------------

seq( RE1, RE2 ) :-

% Clause: alt
%
% Specification:
% --------------
% (Data Structure) Represents the regular expression that matches any list where
% the regular expression RE1  matches the list or the regular expression RE2
% matches the list.
%
% Description:
% ------------

alt( RE1, RE2 ) :-

% Clause: star
%
% Specification:
% --------------
% (Data Structure) Represents the regular expression that matches the empty
% list and matches any list that can be split into one or more lists (such
% that concatenating the lists yields the original list) where the regular
% expression RE matches % each list.
%
% Description:
% ------------

star( RE ) :- RE =:= []; RE =:= [RE].

% Clause: re_match
%
% Specification:
% --------------
% (Predicate) Satisfied when the first regular-expression parameter matches the
% second atom-list parameter. The first parameter may be assumed to always be
% instantiated with a ground term when re_match  is used in a top-level goal;
% the second parameter will likely (but need not) be instantiated with a ground
% term when re_match is used in a top-level goal.
%
% Description:
% ------------
%
re_match( RE, LST ) :- re_match_aux( RE, LST ).

% re_match_aux( RE, L, LS ) :- re_match(



% Test Cases:
%
%   ?- re_match(alt(atom(a),star(atom(b))),[]).
%   true .
%
%   ?- re_match(alt(atom(a),star(atom(b))),[a]).
%   true .
%
%   ?- re_match(alt(atom(a),star(atom(b))),[a,b]).
%   false.
%
%   ?- re_match(alt(atom(a),star(atom(b))),[a,b,b]).
%   false.
%
%   ?- re_match(alt(atom(a),star(atom(b))),[b]).
%   true .
%
%   ?- re_match(alt(atom(a),star(atom(b))),[b,b]).
%   true .
%
%   ?- re_match(alt(atom(a),star(atom(b))),[b,b|Z]).
%   Z = [] ;
%   Z = [b] ;
%   Z = [b, b] ;
%   Z = [b, b, b] ;
%   Z = [b, b, b, b] ;
%   Z = [b, b, b, b, b] .
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[]).
%   false.
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a]).
%   true .
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[b]).
%   false.
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b]).
%   true .
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b,b]).
%   true .
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b,b,c]).
%   true .
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b,b,c,c]).
%   false.
%
%   ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b|Z]).
%   Z = [c] ;
%   Z = [] ;
%   Z = [b, c] ;
%   Z = [b] ;
%   Z = [b, b, c] ;
%   Z = [b, b] ;
%   Z = [b, b, b, c] ;
%   Z = [b, b, b] ;
%   Z = [b, b, b, b, c] .
%
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

btree_to_list( node( LBT, E, RBT ), L ) :- btree_to_list( LBT, LL ),
                                           btree_to_list( RBT, RL ),
                                           append( LL, [E], LF ),
                                           append( LF, RL, L ).

%
% Tests:
%
% btree_to_list(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),L).
%
% = [ 9, 20, 30, 99, 33, 1000 ]
%
% btree_to_list(node(node(leaf,2,leaf),20,node(leaf,50,leaf)), N).
%

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

btree_depth( leaf, 0 ).

% Description:
% ------------
% Traverse the left branch, traverse the right and add the total together.
% If the right count is larger than the left, add one to the right and return N.

btree_depth( node( LBT, _, RBT ), N ) :- btree_depth( LBT, LN ),
                                         btree_depth( RBT, RN ),
                                         RN >= LN, N is (1+RN).
% Description:
% ------------
% Traverse the left branch, traverse the right branch.
% If the left count is larger than the right, add one to the left and return N.

btree_depth( node( LBT, _, RBT ), N ) :- btree_depth( LBT, LN ),
                                         btree_depth( RBT, RN ),
                                         LN >= RN, N is (1+LN).

%
% Tests:
%
% btree_depth(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),N).
%
% = 3
%

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
% Base case for the binary tree iso morphism predicate.
btree_iso( leaf, leaf ).

% Description:
% ------------
btree_iso( node( BTL1, X, BTR1 ), node( BTL2, X, BTR2 ) ) :- btree_iso( BTL1, BTL2 ),
                                                             btree_iso( BTR1, BTR2 ).
% Description:
% ------------
btree_iso( node( BTL1, X, BTR1 ), node( BTL2, X, BTR2 ) ) :- btree_iso( BTL1, BTR2 ),
                                                             btree_iso( BTR1, BTL2 ).



% Test cases:
%
%   Pass:
%
%      - btree_iso(node(node(leaf,3,leaf),3,node(leaf,3,leaf)),BT).
%      - btree_iso(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),node(node(node(leaf,99,leaf),33,node(leaf,1000,leaf)),30,node(leaf,20,node(leaf,9,leaf)))).
%      - btree_iso(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),leaf).
%
%   Fail:
%
%      - btree_iso(node(node(leaf,3,leaf),3,node(leaf,5,leaf)),BT).
%      - btree_iso(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),BT).



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

btree_subtree( leaf, false ).

%
% Description:
% ------------

btree_subtree( node( TL, _, TR ), node( STL, SE, STR ) ):- btree_subtree( TL, node( STL, SE, STR ) ) ;
                                                           btree_subtree( TR, node( STL, SE, STR ) ) ;
                                                           TL  == node( STL, SE, STR ) ;
                                                           TR  == node( STL, SE, STR ).
% Test cases:
%
%  - btree_subtree(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),node(leaf,9,leaf)).
