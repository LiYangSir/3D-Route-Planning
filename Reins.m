 %% �ز����Ӵ�������Ⱥ
 %���룺
 % X  ��������Ⱥ
 % XSel  �Ӵ���Ⱥ
 % fitness   ������Ӧ��
 % ���
 % X  ��ϸ������Ӵ���õ�������Ⱥ
function X=Reins(X,XSel,fit)
NP=size(X,1);
NSel=size(XSel,1);
[~,index]=sort(fit,'descend');
X=[X(index(1:NP-NSel),:);XSel];