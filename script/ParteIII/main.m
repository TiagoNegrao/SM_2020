%Trabalho 1 - Simulação e Modulação
%Ficheiro main / central do código
%Parte 3
%
%Código por
%Tiago Negrao 92990
%Clara Oliveira 97848
%Alunos do Mestrado Integrado em Engenharia Física

clear all
close all
format long
clc

a = 10; b = 20;
R = 0.5; dt = 0.1;  
tmax = 100; ti = 0;
np = 10;
ep = [[1;0] [-1; 0] [0; 1] [0; -1]];

r = posicoes_iniciais(a, b, R, np)
v = randn(2, np)

%Alocar previamente a matriz deltat_parede que tem a mesma fun��o que em
%programas anteriores
deltat_parede = zeros(np, 4)

figure('Name', 'Colisoes elasticas de partícula de Raio R numa caixa (a, b)', 'NumberTitle', 'off')

t = ti;

%Alocar previamente a matriz deltatij que calcula o tempo at� que a colis�o
%entre 2 particulas i e j
deltatij = ones(np) * 10000;
while t <= tmax
    for x = 1 : np
        deltat_parede(x, :) = [(R - r(1, x)) / v(1, x), (a - R - r(1, x)) / v(1, x), (R - r(2, x)) / v(2, x), (b - R - r(2, x)) / v(2,x)]
    end
    
    for i = 1 : np - 1
        for j = i + 1 : np

            %calcular a posicao e velocidade relativas entre i e j
            rij = r(:, i) - r(:, j);
            vij = v(:, i) - v(:, j);
            
            %Defini��o de variaveis
            alpha = (norm(vij))^2;
            beta = 2 * dot(rij, vij);
            gamma = (norm(rij))^2 - 4 * R ^ 2;
            
            %Defini��o que indica quando � que ocorre colis�o e define o
            %tempo para que tal aconte�a
            if beta < -4 * eps && (beta^2) - 4 * alpha * gamma > 4 * eps
                deltatij(i, j) = (- beta - sqrt((beta^2) - 4 * alpha * gamma)); 
            end
        end
    end
    
            %cálculo do deltat em caso de colisão entre particulas
    deltatij (deltatij <= 4 * eps) = 10000;
    
    [min_linha_part, index_jlinha] = min(deltatij, [], 2);
    
    [deltat_part, part_i] = min(min_linha_part);
    
    part_j = index_jlinha(part_i);
    
            %cálculo do deltat em caso de colisão contra paredes
    deltat_parede (deltat_parede < 4 * eps) = 10000;
    
    [min_linha, parede_particula] = min(deltat_parede, [ ], 2);
    
    [deltat_p, particula] = min(min_linha);
    
    if deltat_p < deltat_part
        deltat = deltat_p; 
       
        animacao(r, v, a, b, R, dt, deltat)

        r = r + v * deltat
        plot(r(1, :), r(2, :), 'ro', 'Markersize', 28 * R, 'MarkerFaceColor', 'b')
        
        parede = parede_particula(particula)
    
        v (:, particula) = v(:, particula) - 2  * dot(v(:, particula), ep(:, parede)) * ep(:, parede)
    else
        deltat = deltat_part;
   
        animacao(r, v, a, b, R, dt, deltat)
        
        r = r + v * deltat
        plot(r(1, :), r(2, :), 'ro', 'Markersize', 28 * R, 'MarkerFaceColor', 'b')
        
        rij = r(:, i) - r(:, j);
        vij = v(:, i) - v(:, j);
        
        %Redefini��o da componente da velocidade em caso de colisao entre
        %duas particulas
        v(:, part_i) = v(:, part_i) - (dot(vij, rij) / 4 * R^2)* rij;
        v(:, part_j) = v(:, part_j) + (dot(vij, rij) / 4 * R^2) * rij;
    end
    
    rectangle('Position', [0 0 a b], 'EdgeColor', 'r')
    axis square equal;
    
    t  = t + deltat
end


