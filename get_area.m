function [ whiteRegions ] = get_area( imagePath )
    %UNTITLED �˴���ʾ�йش˺�����ժҪ
    %   �˴���ʾ��ϸ˵��
    imageData = imread(imagePath);
    grayImage = rgb2gray(imageData);

    % �ԻҶ�ͼ�������ֵ�ָ�
    threshold = graythresh(grayImage);
    binaryImage = imbinarize(grayImage, threshold);

    % �Զ�ֵͼ�������ͨ�������
    labeledImage = bwlabel(binaryImage,4);
    regionProps = regionprops(labeledImage, 'Area', 'PixelIdxList');

    % ��ȡ���������ֵ�İ�ɫ����
    areaThreshold = 0;  % �����ֵ������ʵ��������е���
    whiteRegions = [];
    for i = 1 : numel(regionProps)
        if regionProps(i).Area > areaThreshold
        whiteRegions{end+1} = regionProps(i).PixelIdxList;
        end

    end
end


