%% ����������Ĳ�������
% ���룺M��������  Mj�����ޱ�  parent������Ⱦɫ��
% �����parent��������Ⱦɫ��
%% -----------------------------------------------------------------
function parent = repair_for_crossover(M,Mj,parent)
for m = 1:M
    mj = Mj{m};
    if isempty(find(mj==parent(m),1))
       ind = randperm(length(mj),1);
       parent(m) = mj(ind);
    end
end