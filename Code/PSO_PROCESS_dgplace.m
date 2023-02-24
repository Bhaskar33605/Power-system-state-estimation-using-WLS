function [data_final,final_res]=PSO_PROCESS_dgplace(nbus,no_of_int_pop,...
                                no_of_iter,min_val1,max_val1,min_val2,max_val2,...
                                dim,data_pass_to_loadflow)

DG_size_min=min_val2;  % minimum DG size
DG_size_max=max_val2; % maximum DG size
DG_loc_min=min_val1;  % minimum DG size
DG_loc_max=max_val1; % maximum DG size
no_ofdg=dim/2;
for pop_index=1:no_of_int_pop
    dg_infor=[randsrc(1,no_ofdg,DG_loc_min:DG_loc_max) ...
        DG_size_min+(DG_size_max-DG_size_min)*rand(1,no_ofdg)];
    data_initial_pso_pop(pop_index,:)=dg_infor;
end
%% initial psp data fitness calculation 
step_size=0.3;cr_range=0.8;
itermax=no_of_iter;fitnees_value=zeros(1,no_of_int_pop);
match_best=1;DGsize_first_para=data_initial_pso_pop(1,:);
[data_final]=load_flow_process_withdg(nbus,DGsize_first_para,data_pass_to_loadflow);
fitnees_value(1)=data_final{1};bestval= fitnees_value(1);


for indexloop=2:no_of_int_pop
    DGsize_first_para=data_initial_pso_pop(indexloop,:);
    DGsize_first_para=limit_chk_process2(nbus,DGsize_first_para,...
        max_val1,min_val1,max_val2,min_val2,data_pass_to_loadflow);
    [data_final]=load_flow_process_withdg(nbus,DGsize_first_para,data_pass_to_loadflow);
    data_initial_pso_pop(indexloop,:)=DGsize_first_para;
    fitnees_value(indexloop) =data_final{1};
    if (fitnees_value(indexloop) < bestval)
        match_best = indexloop;bestval = fitnees_value(indexloop);
    end
end
best_fit1=data_initial_pso_pop(match_best(1),:);
best_fit=best_fit1;rot=(0:1:no_of_int_pop-1);

%% apply pso over the iteration 
rotd=(0:1:1-1);
iter = 1;
while(iter<itermax)
    old_data_pop =data_initial_pso_pop;
    ind=randperm(4);a1=randperm(no_of_int_pop);
    rt=rem(rot+ind(1),no_of_int_pop);a2=a1(rt+1);
    pm1=old_data_pop(a1,:);pm2=old_data_pop(a2,:);
    for indexloop=1:no_of_int_pop
        bmdatavalue(indexloop,:) = best_fit1;
    end
    mui=rand(no_of_int_pop,no_ofdg*2) < cr_range;mui=sort(mui');
    for indexloop=1:no_of_int_pop
        n=floor(rand*1);
        if n > 0
            rtd = rem(rotd+n,1);
            mui(:,indexloop) = mui(rtd+1,indexloop);
        end
    end
    %% update velocity data
    mui = mui';mpo = mui < 0.5;
    new_data=old_data_pop + step_size*(bmdatavalue-old_data_pop) + step_size*(pm1 - pm2);
        
    new_data=old_data_pop.*mpo + new_data.*mui;
    %% based on new data find fitness
    for indexloop=1:no_of_int_pop
        DGsize_first_para=round(new_data(indexloop,:));
        DGsize_first_para=limit_chk_process2(nbus,DGsize_first_para,...
            max_val1,min_val1,max_val2,min_val2,data_pass_to_loadflow);
        [data_final]=load_flow_process_withdg(nbus,DGsize_first_para,data_pass_to_loadflow);
        new_data(indexloop,:)=DGsize_first_para;tempval=data_final{1};
        if (tempval <= fitnees_value(indexloop))
            data_initial_pso_pop(indexloop,:) = new_data(indexloop,:);
            fitnees_value(indexloop)=tempval;
            if (tempval < bestval)
                bestval = tempval; best_fit = new_data(indexloop,:);
            end
        end
    end
    best_fit1=best_fit;
    final_res(iter)=tempval;
    iter = iter + 1;
    
end
final_res=sort(final_res,'descend');
DGsize_first_para=[round(best_fit1(1:no_ofdg)) best_fit1(no_ofdg+1:end)];
data_final=(DGsize_first_para);



