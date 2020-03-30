%Trabalho 1 - Simulação e Modulação
%Ficheiro main / central do código
%Parte 2
%
%Código por
%Tiago Negrão 92990
%Clara Oliveira
%Alunos do Mestrado Integrado em Engenharia Física

clear all
close all
format long
clc

a = 10; b = 20;
R = 0.5; dt = 0.1;  
tmax = 100; ti = 0;
np = 5;

%Vetores unit�rios respetivos a cada parede
ep = [[1;0] [-1; 0] [0; 1] [0; -1]];

r = posicoes_iniciais(a, b, R, np)
v = randn(2, np)

figure('Name', 'Colisões elásticas de partícula de Raio R numa caixa (a, b)', 'NumberTitle', 'off')

t = ti;
while t <= tmax
    for i = 1 : np
        
        %Calculo do deltat (tempo que a part�cula demoraria a colidir contra
        %uma parede (1 = esquerda, 2 = direita, 3 = baixo, 4 = cima)
        %correspondente a np part�culas em que cada linha corresponde a uma
        %part�cula
        deltat_parede(i, :) = [(R - r(1, i)) / v(1, i), (a - R - r(1, i)) / v(1, i), (R - r(2, i)) / v(2, i), (b - R - r(2, i)) / v(2,i)]
    end
    
    deltat_parede (deltat_parede < 4 * eps) = 10000
    
    %Encontrar os m�nimos de cada linha / part�cula
    [min_linha, parede_particula] = min(deltat_parede, [ ], 2)
    
    %encontrar o minimo deltat universal e a respetiva particula
    [deltat, particula] = min(min_linha)
    
    animacao(r, v, a, b, R, dt, deltat)
    
    r = r + v * deltat
    plot(r(1, :), r(2, :), 'ro', 'Markersize', 28 * R, 'MarkerFaceColor', 'b')
    
    rectangle('Position', [0 0 a b], 'EdgeColor', 'r')
    axis square equal;
    
    %% encontrar qual parede em que a particula se colapsa
    parede = parede_particula(particula)
    
    %% Encontrar a velocidade da part�cula p�s choque
    v (:, particula) = v(:, particula) - 2  * dot(v(:, particula), ep(:, parede)) * ep(:, parede)
    
    t  = t + deltat
end
