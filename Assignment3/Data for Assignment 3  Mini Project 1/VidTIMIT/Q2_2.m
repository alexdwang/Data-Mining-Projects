load('X_test.mat');
load('X_train.mat');
load('y_test.mat');
load('y_train.mat');

tr_Max=size(y_train);
y_trainANN=zeros(3500,25);
for i=1:1:tr_Max
    for j=1:1:25
        if y_train(i,1)==j
            y_trainANN(i,j)=1;
        end
    end
end

net=feedforwardnet(25);
net = configure(net, X_train', y_trainANN');
tic;
net = train(net,X_train', y_trainANN');
toc
resultANN=net(X_test');
resultANN=resultANN';
result=zeros(1000,1);
for i=1:1:1000
    itemmax=resultANN(i,1);
    predict=1;
    for j=2:1:25
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
