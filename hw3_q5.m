data = [1 1 -1 0 2;
        0 0 1 2 0;
        -1 -1 1 1 0;
        4 0 1 2 1;
        -1 1 1 1 0;
        -1 -1 -1 1 0;
        -1 1 1 2 1];
label = [2 1 2 1 1 1 2]';

data = [ones(length(data),1) data];

lbl = logical(label - 1);
data(lbl, :) = - data(lbl,:);

a = [3 1 1 -1 2 -7];
miss = Inf;
while miss > 0
    miss = 0;
    for i = 1:size(data,1)
        y = data(i,:)*a'
        if y < 0
            a = a + data(i,:)
            miss = miss + 1;
        end
    end
end