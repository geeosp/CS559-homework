data = dlmread('pima-indians-diabetes.data');
total = [];
for k = [1 5 11]
    acc = [];
    for it = 1:20

        rp = randperm(length(data));
        data = data(rp,:);

        train_data = data(1:length(data)/2, :);
        test_data = data(length(data)/2+1:end, :);

        active_feat = 2:4;

        % testing
        correct = 0;
        wrong = 0;

        for i = 1:length(test_data)
            sample = test_data(i,active_feat);

            idx = knnsearch(train_data(:,active_feat), sample, 'K', k, 'NSMethod', 'kdtree');

            if sum(train_data(idx, 9)) > k/2
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
    total = [total; acc];
end

meann = mean(total')
stdd = std(total')