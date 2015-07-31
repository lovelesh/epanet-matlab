function [ height ] = tankheight( fillperc, diameter, capacity)
%tankheight gives the height of the waterlevel in OHT
%   Detailed explanation goes here
%   example
%   h=tankheight(34,10.5,500000)
%
%   INPUTS
%   fillperc = fill percentage of the tank
%   diameter = diameter of the tank in metres
%   capacity = capacity of the tank in litres
%
%   OUTPUT
%   height = height of the waterlevel in OHT
%
%   FORMULA
%   pi*(dia/2)^2*h*1000 = capacity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pi = 3.14159265358979323846;
capacity = fillperc/100*capacity;
height = ((capacity/1000)/(pi*(diameter/2)^2));
end

