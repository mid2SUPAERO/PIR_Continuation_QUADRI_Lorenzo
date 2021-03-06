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

%find best combination of 6 initial design
bestdiff=1;
tic
for i=1:size(M,1)
    for j=i+1:size(M,1)
        for k=j+1:size(M,1)
            for l=k+1:size(M,1)
                for m=l+1:size(M,1)
                    for n=m+1:size(M,1)
                        combined=min([M(i,:);M(j,:);M(k,:);M(l,:);M(m,:);M(n,:)]);
                        diffmaxC=0;
                        for o=1:size(M,1)
                            diffmaxC=max(diffmaxC,max((combined-M(o,:))./max([-M(o,:);-combined])));
                        end
                        if diffmaxC<bestdiff
                            bestdiff=diffmaxC;
                            bestDes=[i,j,k,l,m,n];
                        end
                    end
                end
            end
        end
    end
end
toc
combinedIdx6d=bestDes;

Moptim2=min([M(combinedIdx2d(1),:);M(combinedIdx2d(2),:)]);
Moptim3=min([M(combinedIdx3d(1),:);M(combinedIdx3d(2),:);M(combinedIdx3d(3),:)]);
Moptim4=min([M(combinedIdx4d(1),:);M(combinedIdx4d(2),:);M(combinedIdx4d(3),:);M(combinedIdx4d(4),:)]);
Moptim5=min([M(combinedIdx5d(1),:);M(combinedIdx5d(2),:);M(combinedIdx5d(3),:);M(combinedIdx5d(4),:);M(combinedIdx5d(5),:)]);
Moptim6=min([M(combinedIdx6d(1),:);M(combinedIdx6d(2),:);M(combinedIdx6d(3),:);M(combinedIdx6d(4),:);M(combinedIdx6d(5),:);M(combinedIdx6d(6),:)]);
M4=[M;Moptim2;Moptim3;Moptim4;Moptim5;Moptim6];

indicators=zeros(3,size(M4,1));
%1rst row is proportion of optimal values of the design.
%2nd row is max difference with optimal value.
%3rd row is mean difference with optimal value.
for i=1:size(M4,1)
    indicators(1,i)=nnz(~(M4(i,:)-optimums)./abs(optimums));
    indicators(2,i)=max((M4(i,:)-optimums)./abs(optimums)); %err max in percentage
    indicators(3,i)=mean((M4(i,:)-optimums)./abs(optimums)); %err moy in percentage
end
indicators
indicators_to_plot=indicators(:,end-4:end);

%% Plots
figure(1)
loglog(2:6,indicators_to_plot(1,:),'Linewidth',2);
title('N. of optimal values vs N. of initDes values')
grid on

figure(2)
loglog(2:6,indicators_to_plot(2,:),2:6,0.5.*(2:6).^(-1/1.5),'Linewidth',2);
title('Max err vs N. of initDes values')
grid on
legend('Result','Factor -2/3')
xlabel('N. initDes');
ylabel('Max err');

figure(3)
loglog(2:6,indicators_to_plot(3,:),2:6,0.1.*(2:6).^(-2),'Linewidth',2);
title('Mean err vs N. of initDes values')
grid on
legend('Result','Factor -2')
xlabel('N. initDes');
ylabel('Mean err');
%% Info
% 1 prova
%combinedIdx2d=[24,20];
%combinedIdx3d=[3,17,24];
%combinedIdx4d=[6,12,23,24];
%combinedIdx5d=[6,8,12,23,24];

% 2 prova (TZ corrette)
%combinedIdx2d=[14,1];
%combinedIdx3d=[15,21,24];
%combinedIdx4d=[3,14,21,24];
%combinedIdx5d=[1,9,14,18,21];
%combinedIdx6d=[1,6,9,14,18,21];