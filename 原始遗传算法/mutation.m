 %% 变异操作
 % 输入：pop：种群  Pm：变异概率  Mj：禁限表  M：机器数
 % 输出：pop：变异后的种群
 %% ----------------------------------------------------------------
 function pop = mutation(pop,Pm,Mj,M)
 for i= 1:size(pop,1)
     if rand <= Pm
         m = randperm(M,1);    % 随机选择一台机器
         job = pop(i,m);       % 当前机器加工的工序
         mj = Mj{m};           % 所选机器的禁限表
         ind = find(mj~=job);  % 其它可选工序
         if ~isempty(ind)
             pop(i,m) = randperm(length(ind),1);
         end
     end
 end