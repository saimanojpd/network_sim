function [ml_prob,new_state,Inf_Nodes_Index]=inf_prob_during_process(noOfNodes,Inf_Nodes_Index, percen_inf)

max=ceil(percen_inf*noOfNodes/100); 

%rng('shuffle'); %,'multFibonacci'); % 
rng(1,'v5uniform'); % shuffle; 
new_nodes_inf=randi(noOfNodes,1,max)

%% Updated infected nodes_index 
for i=1:length(new_nodes_inf)
   if~ismember(new_nodes_inf(i),Inf_Nodes_Index)
       Inf_Nodes_Index=[Inf_Nodes_Index,new_nodes_inf(i)];
   end
end

%Inf_Nodes_Index=new_nodes_inf;

new_state=zeros(1,noOfNodes);
for i=1:length(Inf_Nodes_Index) 
    new_state(Inf_Nodes_Index(i))=1; 
end

%%% update probabilities
inf_prob=zeros(1,noOfNodes);

for i=1:noOfNodes 
    if new_state(i)==0
        inf_prob(i)=(0.5)*rand; 
    else
        inf_prob(i)=(0.5)*rand+0.5; 
    end
end
ml_prob=inf_prob;


end