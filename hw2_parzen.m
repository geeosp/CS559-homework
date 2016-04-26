clc, clear all;

data = dlmread('pima-indians-diabetes.data');
acc = [];

window = 20;

for times = 1:20

    rp = randperm(length(data));
    data = data(rp,:);
    
    split = length(data)/2;
    train_data = data(split, :);
    test_data = data(split+1:end, :);

    active_feat = 2:4;
    % active_feat = 3;

    % training 
    mean0 = mean(train_data(train_data(:,9)==0, active_feat));
    mean1 = mean(train_data(train_data(:,9)==1, active_feat));

    var0 = var(train_data(train_data(:,9)==0, active_feat));
    var1 = var(train_data(train_data(:,9)==1, active_feat));

    prior0temp = length(train_data(train_data(:,9)==0));
    prior1temp = length(train_data(train_data(:,9)==1));

    prior0 = prior0temp/(prior0temp+prior1temp);
    prior1 = prior1temp/(prior0temp+prior1temp);

    % testing
    correct = 0;
    wrong = 0;

    for i = 1:length(test_data)
        sample = test_data(i,active_feat);

        idx = rangesearch(train_data(:,active_feat), sample, window, 'NSMethod', 'kdtree');
        idx = idx{1}';
        
        if sum(train_data(idx, 9)) > length(idx)/2
            class = 1;
        else
            class = 0;
        end

        if test_data(i,9) == class 
            correct = correct + 1;
        else
            wrong = wrong + 1;
        end
    end

    acc = [acc correct/(correct+wrong)];
end

acc
[mean(acc) std(acc)]