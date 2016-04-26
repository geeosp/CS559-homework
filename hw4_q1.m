D1 = [-2 1; -5 -4; -3 1; 0 -3; -8 -1];
D2 = [2 5; 1 0; 5 -1; -1 -3; 6 1];

% D1 = [6 9; 5 7];
% D2 = [5 9; 0 10];

b = 1;

ld1 = size(D1,1);
ld2 = size(D2,1);

bb = repmat(b,ld1+ld2,1);

Y = [ones(ld1,1) D1;
     -ones(ld2,1) -D2];
 
a = inv(Y'*Y)*Y'*bb;

figure, scatter(D1(:,1), D1(:,2), 'b', '*')
hold on, scatter(D2(:,1), D2(:,2), 'm', '*')
grid on; axis equal;


d = [D1;D2];
tmp = sum([a(2)*d(:,1) a(3)*d(:,2) repmat(a(1),length(d),1)],2);
idx = double(tmp > 0);
idx(idx==0) = -1;

correct = sum(idx==Y(:,1));
disp(['correct: ' num2str(correct) '/' num2str(size(Y,1))])

% hold on;
% scatter(d(idx,1), d(idx,2), 'g', 'LineWidth', 1.5);
% scatter(d(~idx,1), d(~idx,2), 'o','LineWidth', 1.5);

