clear;

noOfNodes  = 20;
L = 200;
R = 50; 

%%%% Create network 
[matrix,distance]=create_network(L, R, noOfNodes); 
disp(matrix); 

weight=distance; 
%%%% Infect the nodes 
noOfInfNodes=2;

%%%% Index and state of Infected nodes
[Inf_Nodes_Index,State_Nodes]=infNodes(noOfNodes,noOfInfNodes);
ml_inf_prob=inf_prob_gen(noOfNodes,Inf_Nodes_Index); %%% Infection probability for nodes in network



%%%%% Propagate the infection though network 
Inf_rate=0.5; 
recovery=0.5;
    
inf_time=inf_time_init(noOfNodes,Inf_Nodes_Index); 
disp(inf_time)  


time=0:10;
%%%% Infection times 
temp_inf_time=0; % Infected time - a temporary variable 
time_chng=[]; % time at which infection happens % time at which infection state changes 1->0 or 0->1 
time_chng=[time_chng,temp_inf_time]; 
X=zeros(1,noOfNodes);  % Infected times of nodes 

%%%% Propagation of infection probabilities ( not 1 or 0) 
p=zeros(noOfNodes,length(time)); % Probabilities of infection for propagation 

decay_rate=0.90; 
percen_inf=10;
step_fwd=0; 
time1=time;

%%%%% Throughput variables and metrics 
thru=[];
Ind_Thru=1; 
temp_thru=(noOfNodes-length(Inf_Nodes_Index))*Ind_Thru; % Throughput at the time instant when state changes 
thru=[thru,temp_thru]; 
ii=0;

while temp_inf_time<=40 % Maximum simulation time is 20 

    prob_updtd_flg=temp_inf_time; % to trigger infection probabilities 
    X=inf_time;
    if ~length(Inf_Nodes_Index) ==0 % If there exists infection then propagate, else wait 
    
    % Generate the probabilities of infection or healthy and choosing a time to forward   
    [p,time_vec]=findtime(p,time,noOfNodes,Inf_Nodes_Index,State_Nodes,Inf_rate,matrix,X,recovery);    
    % p represents the infection propagarion 
    % time_vec represents the time sampled from the propagation curves 
     temp_time_vec=time_vec;
    
     
     
     
     if(min(temp_time_vec)~=max(temp_time_vec)) % that means there exists the propagation
        min_time=min(temp_time_vec); 
        min_indx=find(time_vec==min_time); 
        
        if State_Nodes(min_indx)==1
            State_Nodes(min_indx)=0; % Update the state by making it as infection less 
            Inf_Nodes_Index(Inf_Nodes_Index==min_indx) =[]; % delete from inf list if recovered
           % ml_inf_prob=inf_prob_gen(noOfNodes,Inf_Nodes_Index); %%% Infection probability for nodes in network
        else
            State_Nodes(min_indx)=1; %%% rand for having multiple inf states
            Inf_Nodes_Index=[Inf_Nodes_Index,min_indx];
        
        end
        
        temp_inf_time=min_time+temp_inf_time; 
        time_chng=[time_chng,temp_inf_time]; 
        
         
        
        
        % If this crossed a time instant, then updated infection
        % probabilities 
        if(floor(temp_inf_time)-floor(prob_updtd_flg)==1)
            %%% current state --> generate probs 
            %%% Interpolate probabilities from the cameron's script 
           cam_inf_prob=zeros(1,noOfNodes); 
           
            time_chng=time_chng(1:end-1);
            temp_inf_time=floor(temp_inf_time); 
            time_chng=[time_chng,temp_inf_time];
            %%%%%% Update ml probabilities 
            [ml_prob,State_Nodes]=inf_prob_during_process(noOfNodes,Inf_Nodes_Index, percen_inf); 
            
        end
        
       
        for j=1:noOfNodes
             if min_indx~=j
                matrix(j,min_indx)=0;
                 matrix(min_indx,j)=0;
            end
        end
         
               
     end
      
     
    
    


    
   
        
 
        
     disp('num Inf Nodes');
     disp(length(Inf_Nodes_Index));
     temp_thru=(noOfNodes-length(Inf_Nodes_Index))*Ind_Thru;
     
     thru=[thru,temp_thru]; 
        
    
         
    else
        temp_inf_time=ceil(temp_inf_time); 
        [ml_prob,Inf_Nodes_Index]=node_inf_prob(noOfNodes,percen_inf); 
          disp(Inf_Nodes_Index);   
    
    end

 
end


disp(time_chng);
disp(thru);


figure(2);
hold on;
stairs(time_chng,thru); 

auc=0; 

%%%%% AUC 
for i=1:length(thru)-1
    %auc=auc+thru(i)*(time_chng(i));
    auc=auc+thru(i)*(time_chng(i+1)-time_chng(i));
end
disp(auc);
disp(trapz(time_chng,thru));


