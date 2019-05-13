%Lab 8
%Kara Meyer
%4-30-2019
%Find the value of a natural log

clear all;

%Define the value of p in ln(p)
p=input('What value would you like to know the natural log of? ');

%Define your function
func=@(x)exp(x)-p;

%Find your upper and lower bounds
if p>exp(1)
    xl=1;
    xu=p;
elseif p<exp(1)
    xl=-1/p;
    xu=1;
end

%Test the values to see if there is a root near by if the right value of p
%is entered.
if (p>exp(1) || p<exp(1)) && p>0
    [xr,approxerror,count] = bisectroot(func,xl,xu);

    %If the program is run display this
    if count<100 
        formatSpec =('The natural log of %4.3f is %4.3f.');
        fprintf(formatSpec,p,xr)
    end
elseif p==exp(1)
    disp('The natural log of e is 1.');
else %p<=0
    disp('You cannot have a p value of zero or less than zero.');
    disp('Try a different p value');
end

function [xr,approxerror,count] = bisectroot(func,xl,xu)
%Find xr where the error is less than 0.5%
approxerror = 1;
count=0;
oldxr=100;

while approxerror > 10^-4 && count < 100
    count=count+1;

    %Calculate the value for the midpoint (xr)
    xr=(xu+xl)/2;

    %If f(xl)*f(xr)<0, replace xu=xr 
    %If f(xl)*f(xr)>=0, replace xl=xr
    if func(xl)*func(xr)<0
        xu=xr;
    else
        xl=xr;
    end
    
    %If we have counted 100 times display error message
    if count==100
        disp('This number cannot be solved within 100 runthroughs.');
        disp('Try another number');
        break
    end
    
    %Calculate the approximate error to see how close our solution is
    approxerror=abs(xr-oldxr)/xr*100;
    
    %Save our old guess for the root (old xr)
    oldxr=xr;
end
end