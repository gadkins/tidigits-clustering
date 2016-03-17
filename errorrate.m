function [errrate, incorrect, N] = errorrate(confusion)

N = numel(confusion);
correct = diag(confusion);
incorrect = N - correct;
errrate = incorrect/N;


