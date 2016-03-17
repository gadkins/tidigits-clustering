# tidigits-clustering
Classification model of TIDIGITS corpus via k-mean clustering

K-means clustering is an effective way to classify data without 
annotated labels, as are necessary in supervised learning 
paradigms. The general approach for clustering the data is to 
select k-means (i.e. k-number of averages) from a set of training 
samples, then group the samples according to their nearest mean. 
Once the samples are grouped, a centroid for each cluster is 
calculated, and the centroids together form the model for that set 
of training data. Novel test samples are then compared to the 
model, and a prediction is made about the membership of a given 
sample to one of the classes.

TIDIGITS is a corpus of spoken digits between 0-9. The data 
set makeup includes 326 male and female speakers ranging from 
6 to 70 years of age. The data consists of over twenty 
thousand training and forty-two thousand testing feature files 
extracted via a hidden Markov model toolkit. Each speaker recited
digits 1 through 9 along with “zero” and “oh” two times each 
(i.e. twice as many values of 0 than the other digits), for a 
total of 22 separate feature files. More information about the 
data can be found in the TIDIGITS documentation.

Configuration:

DATA_ROOT should point to your tidigits directory
Expected subdirectories:
   mfc/train - training features
   mfc/test - test features
