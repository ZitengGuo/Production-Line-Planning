%% 调整不可行染色体
% 输入：chrom：个体  B：在制品  Ti：工序加工时间  
%       Lm：单机最大负荷量  mj：禁限表
% 输出：chrom：修复后的个体
%% -----------------------------------------------------------------
function [chrom,B] = repair(B,W,I,chrom,chrom_o,Tc,Ts,Ti,q0,Mj,Lm)
num = zeros(1,I);  % 各工序使用机器数量
for i = 1:I
    num(i) = length(find(chrom==i));
end
load = B.*Ti./num;  % 各工序负荷
while ~isempty(find(B<=0,1))|| ~isempty(find(load>=Lm,1))
    % 在制品数量约束
    while ~isempty(find(B<=0,1))
        [~,ind] = sort(load);   % 负荷从小到大排序
        job1 = ind(1);          % 超出在制品数量的工序
        job2 = ind(end);        % 优先选择负荷最高的工序
        m = find(chrom==job1);  % job1占用的加工机器
        [chrom,tf] = repair_subf(m,Mj,job2,chrom);
        ii = 1;
        while ~tf
            job2 = ind(end-ii);
            [chrom,tf] = repair_subf(m,Mj,job2,chrom);
            ii = ii + 1;
        end
        num(job1) = num(job1) - 1;
        num(job2) = num(job2) + 1;
        B = calculate_B(W,I,chrom,chrom_o,Tc,Ts,Ti,q0);
        load = B.*Ti./num;
    end
    % 单机最大负荷约束
    while ~isempty(find(load>=Lm,1))
        ind1 = find(load>=Lm,1);   % 超过最大负荷的工序
        [~,ind2] = sort(load);     % 工序负荷从小到大排序
        i1 = 1;                    % 从最小负荷工序开始
        i2 = 1;                    % 用于记录可加工机器索引
        m = find(chrom==ind2(i1)); % 最小负荷工序的加工机器
        job_set = Mj{m(i2)};       % 表示当前机器可加工工序集
        len = length(m);           % 表示当前工序已选择的加工机器数
        while isempty(find(job_set==ind1,1))
            i2 = i2 + 1;
            % 目前负荷最小工序选择的机器均无可加工超负荷工序，则换次者重复
            if i2 > len
                i1 = i1 + 1;
                i2 = 1;
                m = find(chrom==ind2(i1));
                len = length(m);
            end
            job_set = Mj{m(i2)};
        end
        chrom(m(i2)) = ind1;
        num(ind2(i1)) = num(ind2(i1)) - 1;
        num(ind1) = num(ind1) + 1;
        B = calculate_B(W,I,chrom,chrom_o,Tc,Ts,Ti,q0);
        load = B.*Ti./num;
    end
end
