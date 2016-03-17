function [confusion, errrate] = tidigitsasr(CorpusDir, k)
% Given the root directory for the TIDIGITS corpus, train VQ models
% with k codewords and evaluate them against test data.
% Expected subdirectories:
%   mfc/train - training features
%   mfc/test - test features
%
% Returns a confusion matrix and error rate [0,1]
% Confusion matrices are 10x10 matrices representing the following
% classes:
%   {zero or oh, one, two, three four, five, six, seven, eight, nine }

classes = 'z123456789';

% Train
traindir = fullfile(CorpusDir, 'mfc', 'train');

for cidx = 1:length(classes)
    
    % Find names of training files for this class.
    id = classes(cidx);
    featurefiles = findfiles(traindir, [id '._01\.mfc'], 'regexp');
     if strcmp(id, 'z')
        % Zero is a special case, also include people saying "O"
        featurefiles = ...
        findfiles(traindir, ['o' '._01\.mfc'], 'regexp');
    end
    
    % Load the training data
    features = spReadFeatureDataHTK(featurefiles{cidx});
    fprintf('Training model %s\n', classes(cidx)); % Train the model

    models{cidx} = VQ_Train(k, features);
end

confusion = zeros(length(classes), length(classes));


% Test
testdir = fullfile(CorpusDir, 'mfc', 'test'); 

for cidx = 1:length(classes)
    % Load test files for this class
    id = classes(cidx);
    featurefiles = findfiles(testdir, [id '._01\.mfc'], 'regexp'); 
    
    if strcmp(id, 'z')
        % Zero is a special case, also include people saying "O"
        featurefiles = ...
        findfiles(testdir, ['o' '._01\.mfc'], 'regexp');
    end
    
    distortions = zeros(length(classes), 1);

    fprintf('Testing %d tokens of class %s\n',length(featurefiles), id);
    for tidx =1:length(featurefiles)
        % Read in test token's features
        features = spReadFeatureDataHTK(featurefiles{tidx});
        % Determine score against each model
        for midx = 1:length(classes)
            distortions(midx) = VQ_MeanMinDistortion(features,models{midx});
        end
        % Make decision
        [~, decision] = min(distortions);
        % Note decision
        confusion(cidx, decision) = confusion(cidx, decision) + 1; 
    end
end

[errrate, incorrect, N] = errorrate(confusion);
fprintf('k=%d Error %.3f (%d/%d)\n', k, errrate, incorrect, N);