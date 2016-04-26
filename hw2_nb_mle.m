data = dlmread('pima-indians-diabetes.data');
gtidx = 9;

acc_nb = [];
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


for times = 1:25

    rp = randperm(length(data));
    data = data(rp,:);
    
    split = 20;
    train_data = data(1:split, :);
    test_data = data(split+1:end, :);

    active_feat = 2:4;
    % active_feat = 3;

    %% Training NB
    mean0_nb = mean(train_data(train_data(:,gtidx)==0, active_feat));
    mean1_nb = mean(train_data(train_data(:,gtidx)==1, active_feat));

    var0_nb = var(train_data(train_data(:,gtidx)==0, active_feat));
    var1_nb = var(train_data(train_data(:,gtidx)==1, active_feat));

    prior0temp_nb = length(train_data(train_data(:,gtidx)==0));
    prior1temp_nb = length(train_data(train_data(:,gtidx)==1));

    prior0_nb = prior0temp_nb/(prior0temp_nb+prior1temp_nb);
    prior1_nb = prior1temp_nb/(prior0temp_nb+prior1temp_nb);
    
    
    %% Training MLE
    mean0 = mean(train_data(train_data(:,gtidx)==0, active_feat));
    mean1 = mean(train_data(train_data(:,gtidx)==1, active_feat));

    cov0 = cov(data(data(:,gtidx)==0,active_feat));
    cov1 = cov(data(data(:,gtidx)==1,active_feat));

    prior0temp = length(train_data(train_data(:,gtidx)==0));
    prior1temp = length(train_data(train_data(:,gtidx)==1));

    prior0 = prior0temp/(prior0temp+prior1temp);
    prior1 = prior1temp/(prior0temp+prior1temp);

    % testing
    correct_nb = 0;
    wrong_nb = 0;
    
    correct = 0;
    wrong = 0;

    for i = 1:length(test_data)
        
        %% Testing NB
        lklhood0_nb = 1; lklhood1_nb = 1;
        for j = active_feat
            lklhood0_nb = lklhood0_nb * exp(-(test_data(i,j)-mean0_nb(j-1)).^2/(2*var0_nb(j-1)))./sqrt(var0_nb(j-1));
            lklhood1_nb = lklhood1_nb * exp(-(test_data(i,j)-mean1_nb(j-1)).^2/(2*var1_nb(j-1)))./sqrt(var1_nb(j-1));
        end
        
        post0_nb = lklhood0_nb*prior0_nb;
        post1_nb = lklhood1_nb*prior1_nb;

        if and(post0_nb > post1_nb, test_data(i,gtidx) == 0)
           correct_nb = correct_nb + 1; 
        elseif and(post0_nb < post1_nb, test_data(i,gtidx) == 1)
           correct_nb = correct_nb + 1; 
        else
           wrong_nb = wrong_nb + 1;
        end
        
        %% Testing MLE
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
    acc_nb = [acc_nb correct_nb/(correct_nb+wrong_nb)];
    
end
disp('Naive Bayes')
[mean(acc_nb) std(acc_nb)]
disp('MLE')
[mean(acc) std(acc)]