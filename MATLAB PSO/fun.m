function  [output]= fun(x );

load 'dadehanet.mat';
outputt=sim(netgear,[x(1);x(2);x(3)]);
%output = (outputt(1)+outputt(2))
output = (outputt(1)+outputt(2)+outputt(3))
end
