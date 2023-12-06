function adjacencyMatrix = getAdjacencyMatrix(imagePath)

    imageData = imread(imagePath);
    grayImage = rgb2gray(imageData);

    % �ԻҶ�ͼ�������ֵ�ָ�
    threshold = graythresh(grayImage);
    binaryImage = imbinarize(grayImage, threshold);

    % �Զ�ֵͼ�������ͨ�������
    labeledImage = bwlabel(binaryImage,4);
    
    % ��ȡ��ͨ��������
     numRegions = max(labeledImage(:));  % ��ȡ��ͨ���������
    
    % ����һ����ֵ�������ڼ�¼�ڽӹ�ϵ
    adjacencyMatrix = zeros(numRegions, numRegions);

     % ����ͼ���ÿ������
    [rows, cols] = size(labeledImage);
    for row = 1:rows
        for col = 1:cols
            currentLabel = labeledImage(row, col);
            % �������Ϊ 0 ������
            if currentLabel == 0
                neighbors = getNeighborPixels(row, col,labeledImage);  % ��ȡ�������ص�λ��
                
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
 
  
    % ����4��������ƫ��
    offsets = [-1 0; 1 0; 0 -1; 0 1;-2 0;2 0;0 -2;0 2; -3 0 ;3 0;0 -3 ;0 3];
    
    % �����������ص�����
    neighborPixels = bsxfun(@plus, offsets, [row col]);
    
    % ��ȡ�������صı�ǩֵ
    neighborLabels = labeledImage(sub2ind(size(labeledImage), neighborPixels(:, 1), neighborPixels(:, 2)));

    % �޳���ǩֵΪ0������
    validNeighborLabels = neighborLabels(neighborLabels ~= 0);

    % �������б�ǩֵ
    allLabels = unique(validNeighborLabels);
    
    neighbors = allLabels
    
end