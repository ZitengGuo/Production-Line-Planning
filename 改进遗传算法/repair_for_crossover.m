%% 交叉操作第四步：修正
% 输入：M：机器数  Mj：禁限表  parent：父代染色体
% 输出：parent：修正的染色体
%% -----------------------------------------------------------------
function parent = repair_for_crossover(M,Mj,parent)
for m = 1:M
    mj = Mj{m};
    if isempty(find(mj==parent(m),1))
       ind = randperm(length(mj),1);
       parent(m) = mj(ind);
    end
end