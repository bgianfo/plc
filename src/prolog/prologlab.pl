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
                                                 merge_two( T1, [H2 | T2], MERG ).

% Description:
% ------------
% If the Head of list one is greater than the head of list two,
% recursively merge the entirety of list one with the tail of list two.
% Finally combine The head of list two with the resultant merged lists.

merge_two( [H1 | T1], [H2 | T2], [H2 | MERG] ):- H1 > H2,
                                                 merge_two( [H1 | T1], T2, MERG ).

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
% ----------------------
tmerge(1) :- ( ( int_mergesort([1,2,3],A),      A == [1,2,3]       ); tw('Fail #m1') ),!,
             ( ( int_mergesort([9,8,6,5,3,2],B),B == [2,3,5,6,8,9] ); tw('Fail #m2') ),!,
             ( ( int_mergesort([5,4,3,2,1],X),  X == [1,2,3,4,5]   ); tw('Fail #m3') ),!,
             ( ( int_mergesort([1,2,3,5,2],D),  D == [1,2,2,3,5]   ); tw('Fail #m4') ),!.
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Regular Expression Operations
%
% Item: epsilon
% --------
% (Data Structure) epsilon represents the regular expression that matches
% the empty list.
%
% Item: atom( A )
%
% Specification
% -------------
% (Data Structure) Represents the regular expression that matches the
% singleton list containing the atom A.
%
% Item: seq ( RE1, RE2 )
%
% Specification:
% --------------
% (Data Structure) Represents the regular expression that matches any list that
% can split into two lists (such that appending the two lists yields the
% original list) where the regular expression RE1  matches the first list
% and the regular expression RE2  matches the second list.
%
% Item: alt( RE1, RE2 )
%
% Specification:
% --------------
% (Data Structure) Represents the regular expression that matches any list where
% the regular expression RE1  matches the list or the regular expression RE2
% matches the list.
%
% Item: star( RE )
%
% Specification:
% --------------
% (Data Structure) Represents the regular expression that matches the empty
% list and matches any list that can be split into one or more lists (such
% that concatenating the lists yields the original list) where the regular
% expression RE matches each list.
%
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
% Match the empty list
re_match( epsilon, [] ).

% Description:
% ------------
% Match an atom to the sinleton list.
re_match( atom( A ), [A] ).

% Description:
% ------------
% Match an atom to the sinleton item.
re_match( atom( A ), A ).

% Description:
% ------------
% Base case for matching the empty list.
re_match( star( _ ), [] ).

% Description:
% ------------
% Match the expression stated by the star to the entire list.
re_match( star( RE ), LST ) :- re_match( RE, LST ).

% Description:
% ------------
% Match the regular expression to any subset of the list recursively.
re_match( star( RE ), [HL|TL] ) :- re_match( star(RE), HL ),!,
                                   re_match( star(RE), TL ),!.

% Description:
% ------------
% Match either of the expressions to the list.
re_match( alt( RE1, RE2 ), LST ) :- ( re_match( RE1, LST ) ; re_match( RE2, LST ) ).

% Description:
% ------------
% Math both expressions to seperate subsets of the list.
re_match( seq( RE1, RE2 ), [H|T] ) :- re_match( RE1, H ),
                                      re_match( RE2, T ).

tre(1) :- ( re_match(alt(atom(a),star(atom(b))),[a]);                                tw('Fail #r1') ),!,
          ( (\+ re_match(alt(atom(a),star(atom(b))),[a,b])   );                      tw('Fail #r2') ),!,
          ( (\+ re_match(alt(atom(a),star(atom(b))),[a,b,b]) );                      tw('Fail #r3') ),!,
          ( (\+ re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[]));  tw('Fail #r4')),!,
          ( (\+ re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[b])); tw('Fail #r5')),!,
          ( (\+ re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b,b,c,c]));  tw('Fail #r6')),!,
          ( re_match(alt(atom(a),star(atom(b))),[a]);                                tw('Fail #r7') ),!,
          ( re_match(alt( atom(a), star( atom(b) ) ), [] );                          tw('Fail #r8') ),!,
          ( re_match( seq( atom(a), seq( star( atom(b) ), alt( atom(c), epsilon ) ) ),[a,b]); tw('Fail #r9') ),!,
          ( re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a]);      tw('Fail #r10') ),!.

% Test Cases:
%
%   Fail:
%
%       ?- re_match(alt(atom(a),star(atom(b))),[b,b|Z]).
%       Z = [] ;
%       Z = [b] ;
%       Z = [b, b] ;
%       Z = [b, b, b] ;
%       Z = [b, b, b, b] ;
%       Z = [b, b, b, b, b] .
%
%       ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a]).
%       true .
%
%       ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b,b]).
%       true .
%
%       ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b,b,c]).
%       true .
%
%       ?- re_match(seq(atom(a),seq(star(atom(b)),alt(atom(c),epsilon))),[a,b|Z]).
%       Z = [c] ;
%       Z = [] ;
%       Z = [b, c] ;
%       Z = [b] ;
%       Z = [b, b, c] ;
%       Z = [b, b] ;
%       Z = [b, b, b, c] ;
%       Z = [b, b, b] ;
%       Z = [b, b, b, b, c] .
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

btree_subtree( node( TL, X, TR ), node( STL, SE, STR ) ):- node( TL, X, TR ) == node( STL, SE, STR ) ;
							   btree_subtree( TL, node( STL, SE, STR ) ) ;
                                                           btree_subtree( TR, node( STL, SE, STR ) ) ;
                                                           TL  == node( STL, SE, STR ) ;
                                                           TR  == node( STL, SE, STR ).
% Test cases:
%
%  - btree_subtree(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),node(leaf,9,leaf)).


tbtree(1) :- ( btree_to_list(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf))),L), L == [9,20,30,99,33,1000] ); tw('Failed #b1'),!,
             ( btree_to_list(node(node(leaf,2,leaf),20,node(leaf,50,leaf)), N), N == [2,20,50] ); tw('Failed #b2'),!.
% Predicate for writing tests.
tw(A) :- write(A),nl,fail.

% Run all parts of the test suite.
runtests :- tmerge(1),tre(1),tbtree(1). 
