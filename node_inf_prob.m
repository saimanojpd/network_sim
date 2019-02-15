function [ml_prob,inf_nodes_indx]=node_inf_prob(noOfNodes,percen_inf)
  
max=ceil(percen_inf*noOfNodes/100); 

rng('shuffle'); % ,'multFibonacci'); % (1,'v5uniform'); % shuffle; 
inf_nodes_indx=randi(noOfNodes,1,max)
inf_prob=zeros(1,noOfNodes);

for i=1:noOfNodes 
    if~ismember(i,inf_nodes_indx)
        inf_prob(i)=(0.5)*rand; 
    else
        inf_prob(i)=(0.5)*rand+0.5; 
    end
end
ml_prob=inf_prob;
