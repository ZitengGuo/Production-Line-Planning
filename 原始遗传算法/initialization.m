%% 种群初始化函数
% 输入：pop_size：种群规模  I：工序数  M：机器总数
%       Mj：禁限表  Ti：加工时间
% 输出：pop：初始种群
%% -----------------------------------------------------------------
function pop = initialization(pop_size,I,M,Mj)
pop = zeros(pop_size,M);
i = 1;
while i <= pop_size
    for m = 1:M
        Sm = Mj{m};
        ind = randperm(length(Sm),1);
        pop(i,m) = Sm(ind);
    end
    % 舍弃工序不加工的染色体，重新生成染色体
    for j = 1:I
        if isempty(find(pop(i,:)==j,1))
            i = i - 1;
            break;
        end
    end
    i = i + 1;
end