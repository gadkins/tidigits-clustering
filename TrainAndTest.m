% Train & test data

DATA_ROOT = '~/Documents/MATLAB/tidigits/';
TRAIN_DIR = 'mfc/train';
TEST_DIR = 'mfc/test';

[confusion, err] = tidigitsasr(DATA_ROOT,50);

visConfusion(confusion, 'Predicted', 'Actual');