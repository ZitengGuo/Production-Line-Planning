%% 判断个体是否均包含所有工序
% 输入：chrom：个体  I：工序数  j：当前迭代数
% 输出：j：更新的迭代数
%% ------------------------------------------------------------------------
function j = judge(chrom,I,j)
for i = 1:I 
    if isempty(find(chrom==i,1))
        j = j - 1;
    end
end
j = j + 1;