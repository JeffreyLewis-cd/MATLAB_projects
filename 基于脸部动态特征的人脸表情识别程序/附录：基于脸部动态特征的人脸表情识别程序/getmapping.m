% �������˵����samplesΪӳ��뾶��mappingtypeΪLBPӳ���ʽ
% �������˵����mappingΪӰ��ģ��
% �������ã����Ӱ��ģ��

function mapping = getmapping(samples,mappingtype)


  
% mapping = 0:2^samples-1;
mapping = 0:2^8-1;
newMax  = 0; %number of patterns in the resulting LBP code
index   = 0;

if strcmp(mappingtype,'u2') %Uniform 2
  newMax = samples*(samples-1) + 3; 
  for  i = 0:2^8-1
       samples=int8(samples);

     j = bitset(bitand(bitshift(i,1),2^8-1),1,bitget(i,samples)); % i ����1λ��Ȼ��ѵ�1λ����Ϊ0��1(iС��128Ϊ0����֮Ϊ1����sampleΪ8ʱ��


    numt = sum(bitget(bitxor(i,j),1:samples)); 
    
    if numt <= 2
      mapping(i+1) = index;
      index = index + 1;
    else
      mapping(i+1) = newMax - 1;
    end
  end
end

if strcmp(mappingtype,'ri') %��ת������
  tmpMap = zeros(2^samples) - 1;
  for i = 0:2^samples-1
    rm = i;
    r  = i;
    for j = 1:samples-1
      r = bitset(bitshift(r,1,samples),1,bitget(r,samples)); %����ת
                                                             
      if r < rm
        rm = r;
      end
    end
    if tmpMap(rm+1) < 0
      tmpMap(rm+1) = newMax;
      newMax = newMax + 1;
    end
    mapping(i+1) = tmpMap(rm+1);
  end
end

if strcmp(mappingtype,'riu2') %������ת������
  newMax = samples + 2;
  for i = 0:2^samples - 1
    j = bitset(bitshift(i,1,samples),1,bitget(i,samples)); %����ת
    numt = sum(bitget(bitxor(i,j),1:samples));
    if numt <= 2
      mapping(i+1) = sum(bitget(i,1:samples));
    else
      mapping(i+1) = samples+1;
    end
  end
end
