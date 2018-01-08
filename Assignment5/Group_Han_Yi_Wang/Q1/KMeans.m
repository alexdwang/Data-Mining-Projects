function [u, re,sse_v,iteration]=KMeans(data,N)
%N    number of classes
%data    raw data
%u    center of each class
%re    clustering result

[m, n]=size(data);      %m is the number of data£¬n is the dimension of data
    ma=zeros(n);        %the biggest number in each dimension
    mi=zeros(n);        %the smallest number in each dimension
    u=zeros(N,n);       %start with a random initialization and end with being centers of those classes
    iteration=0;        %time of iterations
    for i=1:n
       ma(i)=max(data(:,i));    %set of the biggest number in each dimension
       mi(i)=min(data(:,i));    %set of the smallest number in each dimension
       for j=1:N
            u(j,i)=ma(i)+(mi(i)-ma(i))*vpa(rand(),5);  %random initialization
       end      
    end
    while 1
        pre_u=u;            %center pionts in last iteration
        for i=1:N
            tmp{i}=[];
            for j=1:m
                tmp{i}=[tmp{i};data(j,:)-u(i,:)];
            end
        end
        
        quan=zeros(m,N);
        for i=1:m        %Calculate the distance between all data and current u
            c=[];
            for j=1:N
                c=[c norm(tmp{j}(i,:))];
            end
            [~, index]=min(c);
            quan(i,index)=norm(tmp{index}(i,:));           
        end
        
        for i=1:N            %find the raw data that close to current u
           for j=1:n
                u(i,j)=sum(quan(:,i).*data(:,j))/sum(quan(:,i));
           end           
        end
        
        iteration=iteration+1;  %iteration time update
        sse_v=norm(pre_u-u);
        if iteration>1
            if sse_v<0.001   %change in SSE is less than 0.001
                break;
            end
        end
        if iteration>=100        %number of iterations exceeds 100
            break;
        end
    end
    
    re=[];
    for i=1:m
        tmp=[];
        for j=1:N
            tmp=[tmp norm(data(i,:)-u(j,:))];
        end
        [~, index]=min(tmp);
        re=[re;data(i,:) index];
    end

end

