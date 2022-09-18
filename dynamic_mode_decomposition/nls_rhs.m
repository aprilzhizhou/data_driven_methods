function [ output ] = nls_rhs( z,ut,dummy,k )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    u = ifft(ut);
    output = -(i/2)*(k.^2) .*ut + i*fft( (abs(u).^2).*u );

end

