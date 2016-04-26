data = dlmread('pima-indians-diabetes.data');
acc = [];

for times = 1:20

    rp = randperm(length(data));
    data = data(rp,:);

    train_data = data(1:length(data)/2, :);
    test_data = data(length(data)/2+1:end, :);

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
        lklhood0 = 1; lklhood1 = 1;
        for j = active_feat
            lklhood0 = lklhood0 * exp(-(test_data(i,j)-mean0(j-1)).^2/(2*var0(j-1)))./sqrt(var0(j-1));
            lklhood1 = lklhood1 * exp(-(test_data(i,j)-mean1(j-1)).^2/(2*var1(j-1)))./sqrt(var1(j-1));
        end
        
        post0 = lklhood0*prior0;
        post1 = lklhood1*prior1;

        if and(post0 > post1, test_data(i,9) == 0)
           correct = correct + 1; 
        elseif and(post0 < post1, test_data(i,9) == 1)
           correct = correct + 1; 
        else
           wrong = wrong + 1;
        end
    end

    acc = [acc correct/(correct+wrong)];
end

acc
[mean(acc) std(acc)]