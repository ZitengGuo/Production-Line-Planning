 %% �������
 % ���룺pop����Ⱥ  Pm���������  Mj�����ޱ�  M��������
 % �����pop����������Ⱥ
 %% ----------------------------------------------------------------
 function pop = mutation(pop,Pm,Mj,M)
 for i= 1:size(pop,1)
     if rand <= Pm
         m = randperm(M,1);    % ���ѡ��һ̨����
         job = pop(i,m);       % ��ǰ�����ӹ��Ĺ���
         mj = Mj{m};           % ��ѡ�����Ľ��ޱ�
         ind = find(mj~=job);  % ������ѡ����
         if ~isempty(ind)
             pop(i,m) = randperm(length(ind),1);
         end
     end
 end