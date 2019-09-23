%% 交叉操作
% 输入
% XSel  被选择的个体
% Pc    交叉概率
% 输出：
% XSel 交叉后的个体
function XSel=Cross01(XSel,Pc)
[NSel,CityNum]=size(XSel);
for i=1:2:NSel-mod(NSel,2)
    if Pc>=rand %交叉概率Pc
        id=randi(CityNum-2)+1;
        chrom1=XSel(i,:);
        chrom2=XSel(i+1,:);
        XSel(i,:)=[chrom1(1,1:id) chrom2(1,id+1:end)];
        XSel(i+1,:)=[chrom2(1,1:id) chrom1(1,id+1:end)];
    end
end

