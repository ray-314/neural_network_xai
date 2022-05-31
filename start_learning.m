function H = start_learning(X_no_cnstnt, Y, J, seed, filename2save)

rng(seed)

filename2save = [filename2save, num2str(J), '_', num2str(seed), '.mat'];

if exist(filename2save, "file")
    load(filename2save)
    return
end

%%%%%%%%%%%%%��������w�K�i�p�����[�^�͕K�v�ɉ����ĕύX���Ă��������j%%%%%%%%%%%%%%%%%%%
net = feedforwardnet(J);       %�B�ꃆ�j�b�g���̎w��

net.numlayers = 2; % default
net.layers{1}.transferFcn = 'logsig';   % default = 'tansig'
net.layers{2}.transferFcn = 'purelin';  % default
net = configure(net, X_no_cnstnt, Y);

% !!!!!!!!!!!!!!!!
net.inputs{1}.processFcns  = {}; % don't pre-process data
net.outputs{2}.processFcns = {}; % don't post-process data
% !!!!!!!!!!!!!!!!



% % �e�w�Ƀo�C�A�X��������B
% net.biasConnect = [1; 0];
% net.biasConnect = [1;1;1];
% % �w�Ԃ̐ڑ���ύX
% net.layerConnect = [0 0 0; 1 0 0; 0 1 0];
% % �Ō�̑w����o�͂���悤�ɕύX
% net.outputConnect = [0 0 1];
% 
% net.Layers{1}.name = 'Hidden1';
% net.Layers{1}.dimensions = 3;
% net.Layers{2}.name = 'Hidden2';
% net.Layers{2}.dimensions = 3;
% net.Layers{2}.transferFcn = 'tansig'
% net.Layers{3}.name = 'Output';
% net.Layers{3}.dimensions = 6;
% net.Layers{3}.transferFcn = 'purelin';

%net.trainFcn = 'traingdx';
net.trainParam.max_fail = 10000;  %���؃G���[�̍ő�񐔁@�P�O�O�O���ƍl�����Ă��Ȃ��B�������Ă���
net.trainParam.showWindow = false;
net.trainParam.showWindow = true;
net.divideParam.trainRatio = 1.0; % training data
net.divideParam.valRatio = 0.0;   % validation data
net.divideParam.testRatio = 0.0;  % test data
% net.trainParam.epochs = 10000;
% net.performParam.regularization = 0.5;

% [net, tr] = train(net, X_no_cnstnt, Y);
%[net, tr] = train(net, X_no_cnstnt, Y,'useParallel','yes','useGPU','yes','showResources','yes');
[net, tr] = train(net, X_no_cnstnt, Y,'showResources','yes');
% view(net)

%%%%%%%%%%%%%%%%%%%%%%%%%%%�B��w�o�͂̕\��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
imp2 = mapminmax('apply',imp,net.inputs{1}.processSettings{3});
OutLayer1 = tansig(net.IW{1}*imp2+B1); 
OutLayer2 = purelin(net.LW{2}*OutLayer1+B2); 
y2 = mapminmax('reverse',OutLayer2,net.outputs{2}.processSettings{2});
%}

H = sim(net, X_no_cnstnt);
xlabel('time(or num.of images)')
ylabel('activation')
H = H';

%{
plot(H1)
legend('#1','#2','#3','#4')
%}
save(filename2save)     %H1�Ƃ���matfile�ɕۑ�
