%% ����������Ⱦɫ��
% ���룺chrom������  B������Ʒ  Ti������ӹ�ʱ��  
%       Lm��������󸺺���  mj�����ޱ�
% �����chrom���޸���ĸ���
%% -----------------------------------------------------------------
function [chrom,B] = repair(B,W,I,chrom,chrom_o,Tc,Ts,Ti,q0,Mj,Lm)
num = zeros(1,I);  % ������ʹ�û�������
for i = 1:I
    num(i) = length(find(chrom==i));
end
load = B.*Ti./num;  % �����򸺺�
while ~isempty(find(B<=0,1))|| ~isempty(find(load>=Lm,1))
    % ����Ʒ����Լ��
    while ~isempty(find(B<=0,1))
        [~,ind] = sort(load);   % ���ɴ�С��������
        job1 = ind(1);          % ��������Ʒ�����Ĺ���
        job2 = ind(end);        % ����ѡ�񸺺���ߵĹ���
        m = find(chrom==job1);  % job1ռ�õļӹ�����
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
    % ������󸺺�Լ��
    while ~isempty(find(load>=Lm,1))
        ind1 = find(load>=Lm,1);   % ������󸺺ɵĹ���
        [~,ind2] = sort(load);     % ���򸺺ɴ�С��������
        i1 = 1;                    % ����С���ɹ���ʼ
        i2 = 1;                    % ���ڼ�¼�ɼӹ���������
        m = find(chrom==ind2(i1)); % ��С���ɹ���ļӹ�����
        job_set = Mj{m(i2)};       % ��ʾ��ǰ�����ɼӹ�����
        len = length(m);           % ��ʾ��ǰ������ѡ��ļӹ�������
        while isempty(find(job_set==ind1,1))
            i2 = i2 + 1;
            % Ŀǰ������С����ѡ��Ļ������޿ɼӹ������ɹ����򻻴����ظ�
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
