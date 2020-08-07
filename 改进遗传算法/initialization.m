%% 种群初始化函数
% 输入：pop_size：种群规模  I：工序数  M：机器总数  w1,w2: 2种比例  
%       Mj：禁限表  Ti：加工时间
% 输出：pop：初始种群
%% -----------------------------------------------------------------
function pop = initialization(pop_size,I,M,w1,w2,Mj,Ti)
pop = zeros(pop_size,M);
%% 基于局部设备产能均衡的初始化方法
i = 1;
while i <= w1*pop_size
    for m = 1:M
        Sm = Mj{m};   % 机器能加工的工序
        St = Ti(Sm);  % 对应工序加工时间
        prob = St / sum(St);
        prob_cum = cumsum(prob);
        ind = find(prob_cum>rand,1);
        pop(i,m) = Sm(ind);
    end
    i = judge(pop(i,:),I,i);
end
%% 基于全局工序产能均衡的初始化方法
while i <= w2*pop_size
    L = 0.001*ones(1,I);  % 负荷初始化
    M_rand = randperm(M); % 设备随机选择序列
    for m = 1:M
        Sm = Mj{M_rand(m)};
        St = Ti(Sm);
        prob = sum(L(Sm)) ./ L(Sm);
        prob = prob/sum(prob);
        prob_cum = cumsum(prob);
        ind = find(prob_cum>rand,1);
        pop(i,M_rand(m)) = Sm(ind);
        L(Sm(ind)) = L(Sm(ind)) + 1 / St(ind);
    end
    i = judge(pop(i,:),I,i);
end
%% 随机生成的初始化方法
while i <= pop_size
    for m = 1:M
        Sm = Mj{m};
        ind = randperm(length(Sm),1);
        pop(i,m) = Sm(ind);
    end
    i = judge(pop(i,:),I,i);
end