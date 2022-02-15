data=fopen('Totalobj.txt');
M = fscanf(data,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',[24 inf]);
M_opt=min(M);
%find best solution for each case 
optimums=min(M(1:end,:));

%find best compination of two initial designs
diffmaxC=zeros(size(M,1),size(M,1));
for i=1:size(M,1)
    for j=1:size(M,1)
        combined=min([M(i,:);M(j,:)]);
        for k=1:size(M,1)
            diffmaxC(i,j)=max(diffmaxC(i,j),max((combined-M(k,:))./max([-M(k,:);-combined])));
        end
    end
end

[combinedOptims,combinedIdx1]=min(diffmaxC);
[combinedOptim2,combinedIdx2]=min(combinedOptims);
combinedIdx2d=[combinedIdx1(combinedIdx2) combinedIdx2];


%find best combination of 3 initial designs
bestDes=zeros(1,3);
bestdiff=1;
tic
for i=1:size(M,1)
    for j=i+1:size(M,1)
        for k=j+1:size(M,1)
            combined=min([M(i,:);M(j,:);M(k,:)]);
            diffmaxC=0;
            for l=1:size(M,1)
                diffmaxC=max(diffmaxC,max((combined-M(l,:))./max([-M(l,:);-combined])));
            end
            if diffmaxC<bestdiff
                bestdiff=diffmaxC;
                bestDes=[i,j,k];
            end
        end
    end
end
toc
combinedIdx3d=bestDes;

%find best combination of 4 initial designs
bestDes=zeros(1,3);
bestdiff=1;
tic
for i=1:size(M,1)
    for j=i+1:size(M,1)
        for k=j+1:size(M,1)
            for l=k+1:size(M,1)
                combined=min([M(i,:);M(j,:);M(k,:);M(l,:)]);

                diffmaxC=0;
                for m=1:size(M,1)
                    diffmaxC=max(diffmaxC,max((combined-M(m,:))./max([-M(m,:);-combined])));
                end
                if diffmaxC<bestdiff
                    bestdiff=diffmaxC;
                    bestDes=[i,j,k,l];
                end
            end
        end
    end
end
toc
combinedIdx4d=bestDes;
 
%find best combination of 5 initial design
bestdiff=1;
tic
for i=1:size(M,1)
    for j=i+1:size(M,1)
        for k=j+1:size(M,1)
            for l=k+1:size(M,1)
                for m=l+1:size(M,1)
                    combined=min([M(i,:);M(j,:);M(k,:);M(l,:);M(m,:)]);
                    diffmaxC=0;
                    for n=1:size(M,1)
                        diffmaxC=max(diffmaxC,max((combined-M(n,:))./max([-M(n,:);-combined])));
                    end
                    if diffmaxC<bestdiff
                        bestdiff=diffmaxC;
                        bestDes=[i,j,k,l,m];
                    end
                end
            end
        end
    end
end
toc
combinedIdx5d=bestDes;

%combinedIdx2d=[24,20];
%combinedIdx3d=[3,17,24];
%combinedIdx4d=[6,12,23,24];
%combinedIdx5d=[6,8,12,23,24];
Moptim2=min([M(combinedIdx2d(1),:);M(combinedIdx2d(2),:)]);
Moptim3=min([M(combinedIdx3d(1),:);M(combinedIdx3d(2),:);M(combinedIdx3d(3),:)]);
Moptim4=min([M(combinedIdx4d(1),:);M(combinedIdx4d(2),:);M(combinedIdx4d(3),:);M(combinedIdx4d(4),:)]);
Moptim5=min([M(combinedIdx5d(1),:);M(combinedIdx5d(2),:);M(combinedIdx5d(3),:);M(combinedIdx5d(4),:);M(combinedIdx5d(5),:)]);
M4=[M;Moptim2;Moptim3;Moptim4;Moptim5];
% M4=[M;Moptim2;Moptim3];

indicators=zeros(3,size(M4,1));
%1rst row is proportion of optimal values of the design.
%2nd row is max difference with optimal value.
%3rd row is mean difference with optimal value.
for i=1:size(M4,1)
    indicators(1,i)=nnz(~(M4(i,:)-optimums)./abs(optimums));
    indicators(2,i)=max((M4(i,:)-optimums)./abs(optimums)); %err max
    indicators(3,i)=mean((M4(i,:)-optimums)./abs(optimums)); %err moy
end
indicators


