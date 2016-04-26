a = [];

for i = 1:15

data = dlmread('pima-indians-diabetes.data');

rp = randperm(length(data));
data = data(rp,:);

train_data = data(1:length(data)/2, :);
test_data = data(length(data)/2+1:end, :);

tr0 = train_data(train_data(:,9)==0, 1:8);
tr1 = train_data(train_data(:,9)==1, 1:8);

lbl0 = train_data(train_data(:,9)==0, 9);
lbl1 = train_data(train_data(:,9)==1, 9);

[y0,y1,v] = hw3_fisher(tr0, tr1);

acc = hw2_mle_func([y0' lbl0; y1' lbl1], test_data, v, 1, 2, 9);
a = [a acc];

end

mean(a)