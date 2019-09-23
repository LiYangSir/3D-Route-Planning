%% 变异操作
%输入：
% XSel  被选择的个体
% Pm     变异概率
%输出：
% XSel 变异后的个体
function YSel=Mutate01(YSel,Pm)
[NSel,CityNum]=size(YSel);
for i=1:NSel
    if Pm>=rand
        r1=randi(CityNum-2)+1;      % 不包括首末节点
        r2=randi(CityNum-2)+1;
        while r2==r1
            r2=randi(CityNum-2)+1;
        end
        id1=min(r1,r2);
        id2=max(r1,r2);
        YSel(i,id1:id2)=~YSel(i,id1:id2);
    end
    
end
