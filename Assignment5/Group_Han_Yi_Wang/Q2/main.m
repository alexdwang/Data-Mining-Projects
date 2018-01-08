close all;
clear all;

load('X_test.mat');
load('X_train.mat');
load('y_test.mat');
load('y_train.mat');
%(1)k-nearest neighbor
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

%(2)SVM
Y_train=y_train;

count=zeros(3251,10);%(i,j) ith vector, belong to jth class
accuracy=0;

for i=1:10
    svm_train=zeros(500,1);
    for j=1:500
       if Y_train(j,1)==i
           svm_train(j,1)=1;
       else
           svm_train(j,1)=-1;
       end
    end
    [xsup,w,b]=svmclass(X_train,svm_train,10000,0.0001,'poly',2);  
    y=svmval(X_test,xsup,w,b,'poly',2);
    for j=1:3251
       if y(j,1)>0
          count(j,i)=count(j,i)+1;
       else
          count(j,i)=count(j,i)-1;
       end
    end   
end

for i=1:3251
    according=count(i,:);
    [x,y]=max(according);
    if y==y_test(i,1)
        accuracy=accuracy+1/3251;
    end  
end

fprintf('The accuracy using SVM is %.2f%%. \n',accuracy*100);

%(3)Feedforward neural network
tr_Max=size(y_train);
y_trainANN=zeros(500,10);
for i=1:1:tr_Max
    for j=1:1:10
        if y_train(i,1)==j
            y_trainANN(i,j)=1;
        end
    end
end

net=feedforwardnet(25);
net = configure(net, X_train', y_trainANN');
net = train(net,X_train', y_trainANN');

resultANN=net(X_test');
resultANN=resultANN';
result=zeros(3251,1);
for i=1:1:3251
    itemmax=resultANN(i,1);
    predict=1;
    for j=2:1:10
        if resultANN(i,j)>itemmax
            itemmax=resultANN(i,j);
            predict=j;
        end
    end
    result(i,1)=predict;
end

re1=result - y_test;
match3=0;
for i=1:1:row1
    if re1(i,1)==0
        match3 = match3+1;
    end
end

per1=match3/row1;
fprintf('The accuracy using ANN is %.2f%%. \n',per1*100);

%(4)prediction is obtained by taking a majority vote
%pre1 is the prediction result using k-nearest neighbor, count is the
%result using SVM, and result is the result using ANN.

pre2=zeros(3251,1);
for i=1:1:3251
    for j=1:1:10
        if count(i,j)==1
            pre2(i,1)=j;
        end
    end
end
pre3=result;

%need to choose a prediction result first in case the vote ties
election=pre1;      %we choose pre1 because it has highest accuracy
for i=1:1:3251
    if pre3(i,1)==pre2(i,1)
        election(i,1)=pre3(i,1);
    end
end

vote_re=election-y_test;
match4=0;
for i=1:1:row1
    if vote_re(i,1)==0
        match4 = match4+1;
    end
end
ensemble_accu=match4/3251;
fprintf('The accuracy of ensemble is %.2f%%. \n',ensemble_accu*100);