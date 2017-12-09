data=importdata('breast-cancer-wisconsin.data');
list =[100,200,300,400,500,600];
InputData=data(:,2:10);
OutputData=data(:,11);
InputTrainingDataFirst=InputData(1:list(6)/2,:);
InputTrainingDataLast=InputData(size(InputData)-list(6)/2+1:size(InputData),:);
ConcatTrainingInput = cat (1,InputTrainingDataFirst,InputTrainingDataLast);
OutputDataFirst=OutputData(1:list(6)/2,:);
OutputDataLast=OutputData(size(OutputData)-list(6)/2+1:size(OutputData),:);
ConcatTrainingOutput = cat (1,OutputDataFirst,OutputDataLast);
TestingInputData=InputData(list(6)/2+1:size(InputData)-list(6)/2,:);
TestingOutputData=OutputData(list(6)/2+1:size(OutputData)-list(6)/2,:);
net = newff(ConcatTrainingInput',ConcatTrainingOutput',20, {'tansig' 'tansig'}, 'trainr', 'learngd', 'mse');
net.trainParam.goal = 0.01;
net.trainParam.max_fail = 10;
net.trainParam.epochs = 100;
net = train(net, ConcatTrainingInput',ConcatTrainingOutput');
result=net(TestingInputData');
trans_result=result';
count =0;
for i=1:size(trans_result)
if (trans_result(i)<=3)
trans_result(i)=2;
else
trans_result(i)=4;
end
if(trans_result(i)== TestingOutputData(i))
count=count+1;
end
end
percentage=count/size(TestingOutputData,1)*100;
disp(percentage);