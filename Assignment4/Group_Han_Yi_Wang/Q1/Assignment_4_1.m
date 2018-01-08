load('X_test');
load('X_train');
load('y_test');
load('y_train');
Y_train=y_train';

count=zeros(1000,25);%(i,j) ith vector, belong to jth class
accuracy=0;

for i=1:25
    train=zeros(3500,1);
    for j=1:3500
       if Y_train(j,1)==i;
           train(j,1)=1;
       else
           train(j,1)=-1;
       end
    end
    [xsup,w,b]=svmclass(X_train,train,10000,0.0001,'poly',2);  
    y=svmval(X_test,xsup,w,b,'poly',2);
    for j=1:1000
       if y(j,1)>0
          count(j,i)=count(j,i)+1;
       else
          count(j,i)=count(j,i)-1;
       end
    end   
end

for i=1:1000
    according=count(i,:);
    [x,y]=max(according);
    if y==y_test(1,i)
        accuracy=accuracy+1/1000;
    end  
end

accuracy