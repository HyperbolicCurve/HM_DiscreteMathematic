function stack = four_color(AdjacencyMatrix)
    colorarray = {'red','yellow','blue','green'}; % 颜色数组
    map = AdjacencyMatrix;
    
    stack = zeros(1, 128); % 定义栈
    top = 1;
    color = 1; % 颜色
    stack(top) = color; % 第一块区域染色，颜色1入栈
    
    while top <= 128
        while color <= 4 && top <= 128
            stack(top) = color; % 由1开始染色
            while detection(map, stack, top) % 如果检验撞色
                color = color + 1;
                stack(top) = color; % 继续尝试下一颜色
            end
            if color <= 4 % 如果颜色符合范围
                top = top + 1; % 将颜色入栈
                color = 1; % 颜色重置为1
            end
        end
        if color > 4 % 颜色不符合条件就要开始回溯
            top = top - 1;
            color = stack(top) + 1; % 在原有颜色基础上尝试下一种颜色
        end
    end
    
    for k = 1:128
        fprintf('The color of %dth is: %s\n', k, colorarray{stack(k)});
    end
end

function result = detection(map, stack, top)
    for j = 1:128
        if map(j, top) == 1 && stack(top) == stack(j) % 如果相邻且颜色相同则返回1，不同返回0
            result = 1;
            return;
        end
    end
    result = 0;
end
