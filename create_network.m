function [matrix,dist]=create_network(L, R, noOfNodes)

% maximum range;
rand('state', 0);
netXloc = rand(1,noOfNodes)*L;
netYloc = rand(1,noOfNodes)*L;
matrix=zeros(noOfNodes); 
dist=zeros(noOfNodes); 
figure(1);
clf;
hold on;

%%%%% Creating network 
for i = 1:noOfNodes
    plot(netXloc(i), netYloc(i), '.');
    text(netXloc(i), netYloc(i), num2str(i));
    for j = 1:noOfNodes
        distance = sqrt((netXloc(i) - netXloc(j))^2 + (netYloc(i) - netYloc(j))^2);
        if distance <= R
            matrix(i, j) = 1;   % there is a link;
            dist(i,j)=distance; 
            line([netXloc(i) netXloc(j)], [netYloc(i) netYloc(j)], 'LineStyle', ':');
        else
            matrix(i, j) = 0; %inf;
        end
    end
end



end
