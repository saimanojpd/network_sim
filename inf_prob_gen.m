function inf_prob=inf_prob_gen(noOfNodes,Inf_Nodes_Index)

n=noOfNodes; 
inf_prob=zeros(noOfNodes,1); 
for i=1:n
%r = (b-a).*rand(1000,1) + a;
    if i==Inf_Nodes_Index 
        inf_prob(i)=(0.5)*rand+0.5; 
    else
        inf_prob(i)=(0.5)*rand; 
    end
    
    
end



end