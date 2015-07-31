function [ fillperc ] = tankfill( height, diameter, capacity)
%tankfill gives the fill percentage of the waterlevel in OHT
%   Detailed explanation goes here
%   example
%   p=tankfill(2.254,10.5,500000)
%
%   INPUTS
%   height = height of the water column in the tank
%   diameter = diameter of the tank in metres
%   capacity = capacity of the tank in litres
%
%   OUTPUT
%   fillperc = fill percentage of the waterlevel wrt capacity 
%              in OHT
%
%   FORMULA
%   pi*(dia/2)^2*h'*1000 = fillvolume
%   fillperc = fillvolume/capacity * 100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pi = 3.14159265358979323846;
fillvolume = pi * (diameter/2)^2 * height * 1000;
fillperc = fillvolume/capacity * 100;
end