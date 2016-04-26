clc; clear all;

% data = dlmread('pima-indians-diabetes.data');
a = [];

for i = 1:15
data = dlmread('pima-indians-diabetes.data');
rp = randperm(length(data));
data = data(rp,:);

% exclude class label
lbl = data(:,9);
data = data(:,1:8);

train_data = data(1:length(data)/2, :);
test_data = data(length(data)/2+1:end, :);

lbltrain = lbl(1:length(data)/2);
lbltest = lbl(length(data)/2+1:end);

disp('Accuracy when not using PCA: ');
disp(hw2_mle_func([train_data lbltrain], [test_data lbltest], eye(8), 1:8, 9, 9));

[coeff, ~, varian] = princomp(train_data);
mu = mean(train_data);
coeff = coeff(:,1:3);
pca_data = train_data * coeff;

disp('How representative the 3 first pc are: ')
disp(sum(varian(1:3))/sum(varian));

trn = [pca_data lbltrain];
tst = [test_data lbltest];


acc = hw2_mle_func(trn, tst, coeff, 1:3, 4, 9);
disp('Accuracy when using PCA: ');
disp(acc);

disp('------------------------------')

a = [a acc];
end
