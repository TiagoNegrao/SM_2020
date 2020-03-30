%Trabalho 1 - Simula√ß√£o e Modula√ß√£o
%Ficheiro main / central do c√≥digo
%
%C√≥digo por
%Tiago Negr√£o 92990
%Clara Oliveira
%Alunos do Mestrado Integrado em Engenharia F√≠sica

clear all
close all
clc

r = [5; 5]; v =  5*(2*rand(2, 1) - 1); a = 20; b = 10;
R = 0.5; dt = 0.1;  
tmax = 100; ti = 0;

%Vetores unit·rios respetivos a cada parede
ep = [[1;0] [-1; 0] [0; 1] [0; -1]];

figure('Name', 'Colis√µes el√°sticas de part√≠cula de Raio R numa caixa (a, b)', 'NumberTitle', 'off')

t = ti
while t <= tmax
     
    %Calculo do deltat (tempo que a partÌcula demoraria a colidir contra
    %uma parede (1 = esquerda, 2 = direita, 3 = baixo, 4 = cima)
    deltat_parede = [(R - r(1)) / v(1), (a - R - r(1)) / v(1), (R - r(2)) / v(2), (b - R - r(2)) / v(2)];
    
    %Evitar tempos negativos e muitos pequenos transformando-os em n˙meros
    %muito grandes e impossÌveis de serem selecionados
    deltat_parede (deltat_parede < 4 * eps) = 10000
    
    %Selecionar o menor deltat e por consequÍncia identificar a parede que
    %ir· colidir
    [deltat, parede] = min(deltat_parede)
    
    %Fazer animaÁ„o do momento linear uniforme atÈ ao momento que a
    %partÌcula faz a colis„o com a parede
    animacao(r, v, a, b, R, dt, deltat)
    
    %Definir o instante em que a partÌcula toca na parede sem a incerteza
    %dt
    r = r + v * deltat
    plot(r(1), r(2), 'ro', 'Markersize', 28 * R, 'MarkerFaceColor', 'b')
    
    rectangle('Position', [0 0 a b], 'EdgeColor', 'r')
    axis square equal;
    
    %mudanÁa da velocidade pÛs colis„o
    v = v - 2 * dot(v, ep(:, parede)) * ep(:, parede)
    
    t  = t + deltat
end

