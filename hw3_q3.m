D1 = [-2 1; -5 -4; -3 1; 0 -3; -8 -1];
D2 = [2 5; 1 0; 5 -1; -1 -3; 6 1];

[y1,y2,~] = hw3_fisher(D1,D2);

correct = sum(y1 > 0);
correct = correct + sum(y2 < 0);

disp([num2str(correct) '/' num2str(length(D1)+length(D2))])
