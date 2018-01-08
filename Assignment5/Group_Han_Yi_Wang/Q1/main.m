load('seeds.txt');

%k-means clustering for k=3
while 1
    [u,re,sse_v,iteration_time]=KMeans(seeds,3);  %use KMeans function
    [m,n]=size(re);
    if ~isnan(sse_v)
        break;
    end
end
%for i=1:m
%	cl(i,1)=re(i,8);
%end
fprintf('For k=3, SSE values is %d, ',sse_v);

%u is the center points and cl is the clustering result

%k-means clustering for k=3
while 1
    [u,re,sse_v,iteration_time]=KMeans(seeds,5);  %use KMeans function
    [m,n]=size(re);
    if ~isnan(sse_v)
        break;
    end
end
%for i=1:m
%	cl(i,1)=re(i,8);
%end
fprintf('for k=5, SSE values is %d, ',sse_v);

%u is the center points and cl is the clustering result

%k-means clustering for k=7
while 1
    [u,re,sse_v,iteration_time]=KMeans(seeds,7);  %use KMeans function
    [m,n]=size(re);
    if ~isnan(sse_v)
        break;
    end
end
%for i=1:m
%	cl(i,1)=re(i,8);
%end
fprintf('and for k=7, SSE values is %d. ',sse_v);

%u is the center points and cl is the clustering result