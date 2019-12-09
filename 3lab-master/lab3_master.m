%Classification using radial basis function
clc
clear
%sudaromi pradiniai taskai
x=0:1/19:1;
T=(1+0.6*sin(2*pi*x/0.7)+0.3*sin(2*pi*x))/2;
figure(1)
plot(x,T,'kx');

%% train multi perceptron with one inputs and one output

%first layer
% generate random initial values of w1x and bx
[peaks,locs]=findpeaks(T);
c1=x(locs(1,1));
c2=x(locs(1,2));
r1=0.17;
r2=0.17;
w1 = randn(1);
w2 = randn(1);
b1 = randn(1);

F1=zeros(1,20);
F2=zeros(1,20);
%%
% calculate radial functions
for i = 1:20
    F1(i)=exp(-((x(i)-c1)^2)/(2*r1^2));
    F2(i)=exp(-((x(i)-c2)^2)/(2*r2^2));
end
%%
% calculate wieghted sum with randomly generated parameters
for i = 1:20
    v(i)=w1*F1(i)+w2*F2(i)+b1;
end

e1=zeros(1,length(x));

e=0;
e_abs=0;
for i = 1:20
    %paskaiciuojamas rezultatas ir palyginamas su norimu gauti, taip
    %isskaiciuojama klaida
    e1(i)=T(i)-v(i);
    e=e+e1(i);
    e_abs=e_abs+abs(e1(i));
end

% calculate the total error for these inputs 

%training_step
n=0.03;
%max error
error=0.001;
% write training algorithm
j=0;

figure(1)
hold on
plot(x,T,'kx');
plot(x,v,'ro');
hold off
%%

while (j<1000) % executes while the total error is not ((e_abs > error)||0   e_abs>error
    j=j+1;
    
%   update parameters
    for i= 1:20
        %keiciami parametrai antrame sluoksnyje
        w1 = w1 + n*e1(i)*F1(i);
        w2 = w2 + n*e1(i)*F2(i);
        b1 = b1 + n*e1(i);
    end
% 
%   is naujo skaiciuojami pirmo sluoksnio isejimai
   for i = 1:20
    v(i)=w1*F1(i)+w2*F2(i)+b1;
   end

   e1=zeros(1,length(x));

   e=0;
   e_abs=0;
   for i = 1:20
      %paskaiciuojamas rezultatas ir palyginamas su norimu gauti, taip
      %isskaiciuojama klaida
      e1(i)=T(i)-v(i);
      e=e+e1(i);
      e_abs=e_abs+abs(e1(i));
   end
end
%palyginami gauti rezultatai su turimais gauti
figure(2)
hold on
plot(x,T,'kx');
plot(x,v,'ro');
hold off

