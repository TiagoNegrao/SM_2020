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
tmax = 100; ti = 0;

%Vetores unit�rios respetivos a cada parede
ep = [[1;0] [-1; 0] [0; 1] [0; -1]];

figure('Name', 'Colisões elásticas de partícula de Raio R numa caixa (a, b)', 'NumberTitle', 'off')

t = ti
while t <= tmax
     
    %Calculo do deltat (tempo que a part�cula demoraria a colidir contra
    %uma parede (1 = esquerda, 2 = direita, 3 = baixo, 4 = cima)
    deltat_parede = [(R - r(1)) / v(1), (a - R - r(1)) / v(1), (R - r(2)) / v(2), (b - R - r(2)) / v(2)];
    
    %Evitar tempos negativos e muitos pequenos transformando-os em n�meros
    %muito grandes e imposs�veis de serem selecionados
    deltat_parede (deltat_parede < 4 * eps) = 10000
    
    %Selecionar o menor deltat e por consequ�ncia identificar a parede que
    %ir� colidir
    [deltat, parede] = min(deltat_parede)
    
    %Fazer anima��o do momento linear uniforme at� ao momento que a
    %part�cula faz a colis�o com a parede
    animacao(r, v, a, b, R, dt, deltat)
    
    %Definir o instante em que a part�cula toca na parede sem a incerteza
    %dt
    r = r + v * deltat
    plot(r(1), r(2), 'ro', 'Markersize', 28 * R, 'MarkerFaceColor', 'b')
    
    rectangle('Position', [0 0 a b], 'EdgeColor', 'r')
    axis square equal;
    
    %mudan�a da velocidade p�s colis�o
    v = v - 2 * dot(v, ep(:, parede)) * ep(:, parede)
    
    t  = t + deltat
end

