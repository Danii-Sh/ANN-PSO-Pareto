
function [ o ] = ObjectiveFunction (x)
load 'dadehanet.mat';

outputt=sim(netgear,[x(1);x(2);x(3)]);
o = (outputt(3));


end