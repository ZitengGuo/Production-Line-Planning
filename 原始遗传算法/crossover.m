%% �������
% ���룺pop����Ⱥ  Pc���������  Mj�����ޱ�  I��������
% �����pop����������Ⱥ
%% -----------------------------------------------------------------
function pop = crossover(pop,Pc,Mj,M)
for i = 1:2:size(pop,1)-1
    if rand <= Pc
        job = randperm(M,2); % ���ѡ����̨��ͬ����
        job = sort(job);     % �����Ŵ�С��������
        % ��������֮��Ļ����
        tmp = pop(i,job);
        pop(i,job) = pop(i+1,job);
        pop(i+1,job) = tmp;
        % ����
        pop(i,:) = repair_for_crossover(M,Mj,pop(i,:));
        pop(i+1,:) = repair_for_crossover(M,Mj,pop(i+1,:));
    end
end