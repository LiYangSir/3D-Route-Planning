%% ѡ�����
% ����
% X   ��Ⱥ
% fit ��Ӧ��ֵ
% Gap��ѡ�����
% ���
% XSel  ��ѡ��ĸ���
function XSel=Select(X,fit,Gap)
NP=size(X,1);

Px=fit/sum(fit);   % ���ʹ�һ��
Px=cumsum(Px);     % ���̶ĸ����ۼ�

XSel(1:NP*Gap,:)=X(1:NP*Gap,:); % ���ݴ�������ȷ������ѡ��
for i=1:NP*Gap
    sita=rand;
    for j=1:NP
        if sita<=Px(j)
            XSel(i,:)=X(j,:);      
            break;
        end
    end
end
end