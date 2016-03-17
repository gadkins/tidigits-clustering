function mu = VQ_MeanMinDistortion(ColVecs, Codebook)
% VQ_MeanMinDistortion(ColVecs, Codebook)
% Compute the average minimum distortion of all column vectors ColVecs
% with respect to the given Codebook (column vector codewords).


distortions = distortion3(ColVecs,Codebook);

mu = mean(min(distortions));