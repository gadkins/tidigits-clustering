function CodeWords = VQ_Train(NCodeWords, TrainingData, StopFraction)
% Given a matrix TrainingData where each column consists of one
% training sample, create a vector quantizer with NCodeWords.
%
% Training is done with the iterative Lloyd algorithm which is said to
% converge when the ratio of the current iteration's distortion to the
% previous one is StopFraction x 100%. StopFraction defaults to .99
% when it is not specified.

if nargin < 3
    StopFraction = 0.99;
end

% Build initial codebook, choosing NCodewords (k-means)
CodeWords = VQ_InitCodebook(NCodeWords, TrainingData);

% Calculate mean minimum distortion
oldDistortion = distortion3(TrainingData, CodeWords);

[~,min_idx] = min(oldDistortion,[],1);
done = false;
while (~done)

    for i=1:NCodeWords
        partitionIdx = find(min_idx == i);
        if (isempty(partitionIdx))
            CodeWords(:,i) = mean(TrainingData(:,partitionIdx),2);
        end
    end
    
    distortions = distortion3(TrainingData, CodeWords);
    [~, min_idx] = min(distortions, [], 1);
    done = (distortions/oldDistortion)>StopFraction;
    oldDistortion = distortions;
    
end