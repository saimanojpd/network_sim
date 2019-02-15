function inf_time=inf_time_init(noOfNodes,Inf_Nodes_Index)

inf_time=zeros(1,noOfNodes); 
for i=1:noOfNodes
    inf_time(i)=100; 
    if ismember(i,Inf_Nodes_Index)
        inf_time(i)=0;
    end
end

end
