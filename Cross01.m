%% �������
% ����
% XSel  ��ѡ��ĸ���
% Pc    �������
% �����
% XSel �����ĸ���
function XSel=Cross01(XSel,Pc)
[NSel,CityNum]=size(XSel);
for i=1:2:NSel-mod(NSel,2)
    if Pc>=rand %�������Pc
        id=randi(CityNum-2)+1;
        chrom1=XSel(i,:);
        chrom2=XSel(i+1,:);
        XSel(i,:)=[chrom1(1,1:id) chrom2(1,id+1:end)];
        XSel(i+1,:)=[chrom2(1,1:id) chrom1(1,id+1:end)];
    end
end

