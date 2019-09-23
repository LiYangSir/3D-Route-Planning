%% 选择操作
% 输入
% X   种群
% fit 适应度值
% Gap：选择概率
% 输出
% XSel  被选择的个体
function XSel=Select(X,fit,Gap)
NP=size(X,1);

Px=fit/sum(fit);   % 概率归一化
Px=cumsum(Px);     % 轮盘赌概率累加

XSel(1:NP*Gap,:)=X(1:NP*Gap,:); % 根据代沟概率确定进行选择
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