% https://onlinecourses.science.psu.edu/stat414/node/191

data = dlmread('pima-indians-diabetes.data');
gtidx = 9;
acc = [];

% data = [0	6	180	12
%         0	5.92	190	11
%         0	5.58	170	12
%         0	5.92	165	10
%         1	5	100	6
%         1	5.5 150	8
%         1	5.42 130	7
%         1	5.75 150	9];
% 
% gtidx = 1;
    
for times = 1:15

    rp = randperm(length(data));
    data = data(rp,:);

    train_data = data(1:length(data)/2, :);
    test_data = data(length(data)/2+1:end, :);
    
%     train_data = data;
%     test_data = data(length(data)/2+1:end, :);

    active_feat = 2:4;
    % active_feat = 3;
   

    % training 
    mean0 = mean(train_data(train_data(:,gtidx)==0, active_feat));
    mean1 = mean(train_data(train_data(:,gtidx)==1, active_feat));

    cov0 = cov(train_data(train_data(:,gtidx)==0,active_feat));
    cov1 = cov(train_data(train_data(:,gtidx)==1,active_feat));

    prior0temp = length(train_data(train_data(:,gtidx)==0));
    prior1temp = length(train_data(train_data(:,gtidx)==1));

    prior0 = prior0temp/(prior0temp+prior1temp);
    prior1 = prior1temp/(prior0temp+prior1temp);

    % testing
    correct = 0;
    wrong = 0;
    
%   test_data = [1 6 130 8];

    for i = 1:size(test_data, 1)
        
        x = test_data(i,active_feat);
        
        lh0 = exp(-1/2*(x-mean0)*inv(cov0)*(x-mean0)')/sqrt(det(cov0));
        lh1 = exp(-1/2*(x-mean1)*inv(cov0)*(x-mean1)')/sqrt(det(cov1));
        
        post0 = lh0*prior0;
        post1 = lh1*prior1;

        if and(post0 > post1, test_data(i,gtidx) == 0)
           correct = correct + 1; 
        elseif and(post0 < post1, test_data(i,gtidx) == 1)
           correct = correct + 1; 
        else
           wrong = wrong + 1;
        end
    end

    acc = [acc correct/(correct+wrong)];
end

acc
[mean(acc) std(acc)]