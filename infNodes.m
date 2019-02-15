function [infNodes_Index,Inf_Nodes]=infNodes(noOfNodes,noOfInfNodes)

rng('shuffle','multFibonacci'); % (1,'v5uniform'); % shuffle; 
%infNodes_Index=randi(noOfNodes,1,noOfInfNodes); 
%rng shuffle;
infNodes_Index=randperm(noOfNodes,noOfInfNodes); 

%infNodes_Index=[2 3]; 

%disp(infNodes_Index); 




InfNodes_temp=zeros(1,noOfNodes);
for i=1:noOfInfNodes
    InfNodes_temp(infNodes_Index(i))=1; 
end
Inf_Nodes=InfNodes_temp; 

end