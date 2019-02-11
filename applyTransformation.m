function [O] = applyTransformation (F,C)
% This function will apply transformation on a padded feature matrix (5x3)
% wrt the given affine transformation matrix 3x2
O = F*C;
