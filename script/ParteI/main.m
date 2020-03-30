%Trabalho 1 - Simulação e Modulação
%Ficheiro main / central do código
%
%Código por
%Tiago Negrão 92990
%Clara Oliveira
%Alunos do Mestrado Integrado em Engenharia Física

clear all
close all
clc

r = [5; 5]; v =  5*(2*rand(2, 1) - 1); a = 20; b = 10;
R = 0.5; dt = 0.1;  
tmax = 10; ti = 0;
ep = [[1;0] [-1; 0] [0; 1] [0; -1]];

figure('Name', 'Colisões elásticas de partícula de Raio R numa caixa (a, b)', 'NumberTitle', 'off')

t = ti
while t <= tmax
     
    deltat_parede = [(R - r(1)) / v(1), (a - R - r(1)) / v(1), (R - r(2)) / v(2), (b - R - r(2)) / v(2)];
    
     deltat_parede (deltat_parede < 4 * eps) = 10000
    
    [deltat, parede] = min(deltat_parede)
    
    animacao(r, v, a, b, R, dt, deltat)
    
    r = r + v * deltat
    plot(r(1), r(2), 'ro', 'Markersize', 28 * R, 'MarkerFaceColor', 'b')
    
    rectangle('Position', [0 0 a b], 'EdgeColor', 'r')
    axis square equal;
    
    v = v - 2 * dot(v, ep(:, parede)) * ep(:, parede)
    
    t  = t + deltat
end

