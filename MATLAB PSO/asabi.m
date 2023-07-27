clc
clear
close all


data=xlsread('data.xls')';

[m,n]=size(data);


in=data(1:3,:);
out=data(4:6,:);



%[out_norm1,mino1,maxo1]=premnmx(out);
[out1,out2] = mapminmax(out)
out_norm = out1
[maxo]=out2.xmax
[mino]=out2.xmin
netgear=newff(minmax(in),[24 12 18 24 3],{'tansig' 'tansig' 'tansig' 'tansig' 'satlins'});
netgear.trainParam.epochs=100;
netgear.trainParam.goal=7e-6;
netgear.trainParam.time=100;
netgear.performFcn='mse';

netgear=train(netgear,in,out_norm);

out_test_norm=sim(netgear,in);
out_test=postmnmx(out_test_norm,mino,maxo);

figure(1)
plot(out(1,:),'rd','LineWidth',3)
grid on
hold on
plot(out_test(1,:),'--','LineWidth',1)
hold off
legend('real data1','test1')


figure(2)
plot(out(2,:),'rd','LineWidth',3)
grid on
hold on
plot(out_test(2,:),'--','LineWidth',1)
hold off
legend('real data2','test2')


figure(3)
plot(out(3,:),'rd','LineWidth',3)
grid on
hold on
plot(out_test(3,:),'--','LineWidth',1)
hold off
legend('real data3','test3')

save dadehanet
% 
% t = sim (netgear,in(:,1) )
% r = sim (netgear,[1;1;5] )
% s = sim (netgear,[8.3;45.4;60.4] )
% s(1)
% 
% zz = sim (netgear,[50;325;0.0850000000000000])