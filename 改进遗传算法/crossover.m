%% �������
% ���룺pop����Ⱥ  Pc���������  Mj�����ޱ�  I��������
% �����pop����������Ⱥ
%% -----------------------------------------------------------------
function pop = crossover(pop,Pc,Mj,I,M)
for i = 1:2:size(pop,1)-1
    if rand <= Pc
        parent1 = pop(i,:);
        parent2 = pop(i+1,:);
        % ѡ��
        job = randperm(I,1);
        % �滻
        ind1 = find(parent1==job);   % ����1����ѡ����ʹ�õĻ���
        ind2 = find(parent2==job);   % ����2����ѡ����ʹ�õĻ���
        ind = intersect(ind1,ind2);  % ��ͬ����
        for j = 1:length(ind)
            ind1(ind1==ind(j)) = [];  % ��ͬ����������
            ind2(ind2==ind(j)) = [];  % ��ͬ����������
        end
        job1 = parent1(ind2);  % ��¼����1�滻���Ĺ���
        job2 = parent2(ind1);  % ��¼����2�滻���Ĺ���
        parent1(ind2) = job;   % �滻��ѡ����
        parent2(ind1) = job;   % �滻��ѡ����
        % ���
        if length(ind1) == length(ind2)
            % ���1����ȱλ�����滻�������
            parent1(ind1) = job1;
            parent2(ind2) = job2;
        elseif length(ind1) < length(ind2)
            [parent1,parent2] = adjustment_for_crossover(parent1,ind1,job1,parent2,ind2,job2,Mj);
        else
            [parent2,parent1] = adjustment_for_crossover(parent2,ind2,job2,parent1,ind1,job1,Mj);
        end
        % ����
        pop(i,:) = repair_for_crossover(M,Mj,parent1);
        pop(i+1,:) = repair_for_crossover(M,Mj,parent2);
    end
end