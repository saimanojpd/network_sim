%function time_matrix=findtime(p,time,noOfNodes,Inf_Nodes_Index,State_Nodes,Inf_rate,matrix1,step_fwd)
function [p,time_vector]=findtime(p,time,noOfNodes,Inf_Nodes_Index,State_Nodes,Inf_rate,matrix1,step_fwd,X)

rec_rate=0.3; %Inf_rate;
%disp(time); 
%temp=0;
%disp(time); 
disp('state_nodes'); 
disp(State_Nodes)
%time_step=0.1; 

%time=time+step_fwd;
%disp('step fwd is');
%disp(step_fwd); 
%disp('time is'); 
%disp(time); 

temp=zeros(noOfNodes,length(time));

for i=1:noOfNodes 
    for t=1:length(time)
        if ~ismember(i,Inf_Nodes_Index)
            for j=1:noOfNodes    
                if i~=j
                    temp(i,t)=temp(i,t)+(State_Nodes(j)*matrix1(i,j)*Inf_rate);
                end
            end
   
        p(i,t)=exp(-temp(i,t)*time(t));
        %temp=0;  
        else
            %%%%%% Add new curve 
        %    p(i,t)=0; % 1-exp(-temp*time_step*time(t));
        temp(i,t)=rec_rate;
        p(i,t)=exp(-rec_rate*time(t)); % 1-exp(-temp*time_step*time(t));
        
        end
    
    end
end
disp(p);
p=single(p); 
ttemp=zeros(1,noOfNodes); 
%disp(temp);
for i=1:noOfNodes
   ttemp(i)=mean(temp(i,:)); 
end
    


for i=1:noOfNodes
   % if ismember(i,Inf_Nodes_Index)
    %    X(i)=time(1);
   % else
        %disp(i);
        mmi=min(p(i,:));
        mma=max(p(i,:)); 
        if mmi~=mma
            prob=(mmi+((mma-mmi)*rand)); %%%% choosing a random point in curve
           % disp(prob);
            X(i)=(-log(prob)/ttemp(i))+time(1); 
            %disp(X(i));
        else
            %disp(i);
            X(i)=inf; 
        end
   % end
   
end

time_vector=X;

% disp(time_vector); 
% 
% figure(2);
% hold on; 
% 
% for i=1:noOfNodes
%     plot(p(i,:)); 
% end
% 
% 
% 
% X = (max(time)-min(time))*rand(1,noOfNodes,'like',p)+min(time);
% %disp(min(X));
% %disp(max(X));
% 
% 
% for i=1:length(Inf_Nodes_Index)
%    X(Inf_Nodes_Index(i))=0; 
% end
% 
% %disp(X); 
% 
% time_matrix=X; 
