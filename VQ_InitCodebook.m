function Codebook = VQ_InitCodebook(NCodeWords, TrainingVecs)
% VQ_InitCodebook(NCodeWords, TrainingVecs)
% Given a set of column vectors as training data, draw an initial
% codebook of NCodeWords.

% Pick NCodeWords at random
RandIndices = randperm(size(TrainingVecs, 2));
InitCodeWordIndices = RandIndices(1:NCodeWords);

% Pick the first N codewords as initial guess.
Codebook = TrainingVecs(:, InitCodeWordIndices);
