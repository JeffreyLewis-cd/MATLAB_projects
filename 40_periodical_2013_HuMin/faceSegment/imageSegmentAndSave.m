clear;
stImageFilePath  = 'C:\Users\jiang\Desktop\temp\jiangfan_face\AN\';
stImageSavePath  = 'C:\Users\jiang\Desktop\temp\jiangfan_face\AN_face_only\';
dirImagePathList = dir(strcat(stImageFilePath,'*.png'));        %��ȡ��Ŀ¼��ȫ��ͼƬ��·�����ַ�����ʽ��
iImageNum        = length(dirImagePathList);                    %��ȡͼƬ��������
if iImageNum > 0                                                %��������ͼƬ��������ټ�y����������y
    for i = 1 : iImageNum
        iSaveNum      = int2str(i);
        stImagePath   = dirImagePathList(i).name;
        mImageCurrent = imread(strcat(stImageFilePath,stImagePath));
        
        mFaceResult   = face_segment(mImageCurrent);
        mFaceResult = histeq(imresize(mFaceResult,[256,256])); %ͼ��ߴ����ţ�����ֱ��ͼ���⻯
        imwrite(mFaceResult,strcat(stImageSavePath,dirImagePathList(i).name)); 
    end 
end