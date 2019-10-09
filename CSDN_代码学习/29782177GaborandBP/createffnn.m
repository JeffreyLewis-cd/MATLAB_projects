% Version : 4.10
% Author  : Omid Bonakdar Sakhi

net = network;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%
% This function creates a feedforward neural network with 100 
% neurons in the input layer and 1 neuron in the output layer.
% to study more about how to create a network like this see help files 
% for Neural Network Toolbox - Advance Concepts
%
% The network will be saved to 'net.m' for future use.

net.numInputs = 1;
net.numLayers = 2;

net.biasConnect = [1;1];

net.inputConnect = [1 ;...
                    0 ];

net.layerConnect = [0 0 ;...
                    1 0 ];
                
net.outputConnect = [0 1];                
net.targetConnect = [0 1];

netInputs = ones (2160,2);
netInputs (1:2160,1)= -1;
net.inputs{1}.range = netInputs;

net.layers{1}.size = 100;
net.layers{2}.size = 1;

net.layers{1:2}.transferFcn = 'tansig';
net.layers{1:2}.initFcn = 'initnw';

net.initFcn = 'initlay';
net.performFcn = 'msereg';
net.trainFcn = 'trainscg';

net = init(net)
save net net