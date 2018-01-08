load('X_test');
load('X_train');
load('y_test');
load('y_train');

prelabel=zeros(907,6);
accuracy=0;

Y_train=ones(1500,6);
for i=1:1500
    for j=1:6
        if y_train(i,j)==0
            Y_train(i,j)=-1;
        end
    end
end


for i=1:6
    temp=zeros(907,1);
    train=Y_train(:,i);
    tic
    [xsup,w,b]=svmclass(X_train,train,10000,0.0001,'gaussian',2);
    toc
    tic
    temp=svmval(X_test,xsup,w,b,'gaussian',2);
    toc
    for j=1:907
       if temp(j,1)>0
           prelabel(j,i)=1;
       else
           prelabel(j,i)=0;
       end
    end    
end

for i=1:907
   label=y_test(i,:);
   pre=prelabel(i,:);
   num=0;
   den=0;
   for j=1:6
      if label(j)==1&&pre(j)==1
          num=num+1;
          den=den+1;
      else
          if label(j)==1||pre(j)==1
              den=den+1;
          end
      end
   end
   accuracy=accuracy+(sqrt(num)/sqrt(den))/907;
end

accuracy