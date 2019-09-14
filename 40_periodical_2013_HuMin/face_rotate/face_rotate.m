

stImageFilePath  = 'D:\backupData\JiangFanBackup_Tech\videoImage\master\MATLAB_projects\40_periodical_2013_HuMin\KA_sets\KA\';
stImageSavePath  = 'D:\backupData\JiangFanBackup_Tech\videoImage\master\MATLAB_projects\40_periodical_2013_HuMin\KA_sets\KA_rotate\';
dirImagePathList = dir(strcat(stImageFilePath,'*.tiff'));        %��ȡ��Ŀ¼��ȫ��ͼƬ��·�����ַ�����ʽ��
iImageNum        = length(dirImagePathList);                    %��ȡͼƬ��������
if iImageNum > 0                                                %��������ͼƬ��������ټ�y����������y
    for i = 1 : iImageNum
        iSaveNum      = int2str(i);
        stImagePath   = dirImagePathList(i).name;
        mImageCurrent = imread(strcat(stImageFilePath,stImagePath));
        
        mFaceResult   = imageRotate(mImageCurrent,i);
     
        imwrite(mFaceResult,strcat(stImageSavePath,iSaveNum,'.bmp')); 
    end 
end