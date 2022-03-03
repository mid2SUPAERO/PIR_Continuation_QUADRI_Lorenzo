function display_3D(rho)
[nely,nelx,nelz] = size(rho);
hx = 1; hy = 1; hz = 1;            % User-defined unit element size
face = [1 2 3 4; 2 6 7 3; 4 3 7 8; 1 5 8 4; 1 2 6 5; 5 6 7 8];
set(gcf,'Name','ISO display','NumberTitle','off');
% set(gca, 'ZDir','reverse');

for k = 1:nelz
    z = (k-1)*hz;
    for i = 1:nelx 
    %for i = round(nelx/2):nelx % to show half cube
        x = (i-1)*hx;
        for j = 1:nely
        % for j = round(nely/2):nely % to show half cube cut at y/2
            %y = nely*hy - (j-1)*hy;
            y = nely*hy-(j-1)*hy;
            if (rho(j,i,k) > 0.5)  % User-defined display density threshold
                %vert = [x y z; x y-hx z; x+hx y-hx z; x+hx y z; x y z+hx;x y-hx z+hx; x+hx y-hx z+hx;x+hx y z+hx];
                vert = [z y x; z y-hx x; z y-hx x+hx; z y x+hx; z+hx y x;z+hx y-hx x; z+hx y-hx x+hx;z+hx y x+hx];
                vert(:,[2 3]) = vert(:,[3 2]); %vert(:,2,:) = vert(:,2,:);
                patch('Faces',face,'Vertices',vert,'FaceColor',[0.2+0.8*(1-rho(j,i,k)),0.2+0.8*(1-rho(j,i,k)),0.2+0.8*(1-rho(j,i,k))]);
                hold on;
            end
        end
    end
end
axis equal; axis tight; axis on; xlabel('z'); ylabel('x'); zlabel('y');
box on; view([120,30]); pause(1e-6); % to show axis
% axis equal; axis tight; axis off; box on; view([30,30]); pause(1e-6); 
end