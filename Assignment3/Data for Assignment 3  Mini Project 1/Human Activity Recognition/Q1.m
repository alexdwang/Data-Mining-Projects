load('X_test.txt');
load('X_train.txt');
load('y_test.txt');
load('y_train.txt');

Mdl1 = fitcknn(X_train,y_train,'NumNeighbors',7);
pre1 = predict(Mdl1, X_test);
re1=pre1 - y_test;
[row1,col1]=size(y_test);
match1=0;

for i=1:1:row1
if re1(i,1)==0
match1 = match1+1;
end
end

per1=match1/row1;
fprintf('The accuracy using k-nearest neighbor with k = 7 is %.2f%%. \n',per1*100);