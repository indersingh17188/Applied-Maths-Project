function [C] = findTransformation (F1,F2x,F2y)
%this function will find affine transformation and return a  3*2 matrix C
%contains both A & b components such that C = [a11 a12 b1;a21 a22 b2]
%the input to this function will be a padded feature matrix (5x3) wrt which we
%have to find transformation and 2 vectors of x & y feature points 
C1 = pinv(F1)*F2x;
C2 = pinv(F1)*F2y;
C=[C1 C2];