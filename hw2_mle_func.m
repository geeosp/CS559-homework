function acc = hw2_mle_func(train_data, test_data, matrix, active_feat, lblidxtrain, lblidxtest)
    % acc = hw2_mle_func(train_data, test_data, matrix, active_feat, lblidxtrain, lblidxtest)
    
    % training 
    mean0 = mean(train_data(train_data(:,lblidxtrain)==0, active_feat));
    mean1 = mean(train_data(train_data(:,lblidxtrain)==1, active_feat));

    cov0 = cov(train_data(train_data(:,lblidxtrain)==0,active_feat));
    cov1 = cov(train_data(train_data(:,lblidxtrain)==1,active_feat));

    prior0temp = length(train_data(train_data(:,lblidxtrain)==0));
    prior1temp = length(train_data(train_data(:,lblidxtrain)==1));

    prior0 = prior0temp/(prior0temp+prior1temp);
    prior1 = prior1temp/(prior0temp+prior1temp);


    % testing
    correct = 0;
    wrong = 0;

    for i = 1:size(test_data, 1)
        x = test_data(i,1:8)*matrix;
        
        lh0 = exp(-1/2*(x-mean0)*inv(cov0)*(x-mean0)')/sqrt(det(cov0));
        lh1 = exp(-1/2*(x-mean1)*inv(cov0)*(x-mean1)')/sqrt(det(cov1));
        
        post0 = lh0*prior0;
        post1 = lh1*prior1;

        if and(post0 > post1, test_data(i,lblidxtest) == 0)
           correct = correct + 1; 
        elseif and(post0 < post1, test_data(i,lblidxtest) == 1)
           correct = correct + 1; 
        else
           wrong = wrong + 1;
        end
    end

%     [correct correct+wrong]
    acc = correct/(correct+wrong);
end