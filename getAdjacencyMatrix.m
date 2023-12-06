function adjacencyMatrix = getAdjacencyMatrix(imagePath)

    imageData = imread(imagePath);
    grayImage = rgb2gray(imageData);

    % 对灰度图像进行阈值分割
    threshold = graythresh(grayImage);
    binaryImage = imbinarize(grayImage, threshold);

    % 对二值图像进行连通区域分析
    labeledImage = bwlabel(binaryImage,4);
    
    % 获取连通区域数量
     numRegions = max(labeledImage(:));  % 获取连通区域的数量
    
    % 创建一个二值矩阵用于记录邻接关系
    adjacencyMatrix = zeros(numRegions, numRegions);

     % 遍历图像的每个像素
    [rows, cols] = size(labeledImage);
    for row = 1:rows
        for col = 1:cols
            currentLabel = labeledImage(row, col);
            % 遍历标记为 0 的像素
            if currentLabel == 0
                neighbors = getNeighborPixels(row, col,labeledImage);  % 获取相邻像素的位置
                
               s=size(neighbors);
               if s(1)==0 || s(1)==1
        
               else
                   for i=1 : s(1)
                       for j= i+1:s(1)
                           n1=neighbors(i)
                           n2=neighbors(j)
                          adjacencyMatrix(neighbors(i),neighbors(j))=1;
                          adjacencyMatrix(neighbors(j),neighbors(i))=1;
                       end
                   end
               end
            end
        end
    end
end



function neighbors = getNeighborPixels(row, col,labeledImage)
 
  
    % 定义4邻域的相对偏移
    offsets = [-1 0; 1 0; 0 -1; 0 1;-2 0;2 0;0 -2;0 2; -3 0 ;3 0;0 -3 ;0 3];
    
    % 计算相邻像素的坐标
    neighborPixels = bsxfun(@plus, offsets, [row col]);
    
    % 获取相邻像素的标签值
    neighborLabels = labeledImage(sub2ind(size(labeledImage), neighborPixels(:, 1), neighborPixels(:, 2)));

    % 剔除标签值为0的像素
    validNeighborLabels = neighborLabels(neighborLabels ~= 0);

    % 查找所有标签值
    allLabels = unique(validNeighborLabels);
    
    neighbors = allLabels
    
end