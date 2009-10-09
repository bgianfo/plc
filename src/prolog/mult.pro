

% Multiplication in prolog for posotive numbers

mult(_,1,X).
mult(X,Y,Z) :- A is Y - 1, mult(X,A,B), Z is B + X.
