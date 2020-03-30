%     Trabalho 1 - Simulação e Modulação
%     Parte 1
%     Ficheiro responsável pela função animação
% 
%     Anima o movimento de uma partícula de raio R e as suas colisões elásticas
%     num recipiente a por b.
%     Calcula e identifica a próxima parede com que a partícula irá colidir
% 
%     Código por
%     Tiago Negrão 92990
%     Clara Oliveira
%     Alunos do Mestrado Integrado em Engenharia Física

function animacao(r, v, a, b, R, dt, deltat) 
    assert(r(1) >= 0 && r(1) <= a, 'É necessário respeitar condição 0 <= x <= a')
    assert(r(2) >= 0 && r(2) <= b, 'É necessário respeitar condição 0 <= y <= b')
    assert(a > 0 && b > 0, 'É necessário que as dimensões do recipiente sejam positivas') 
    
    %Definir a posi��o inicial r0
    inicial = r
    tempo = 0
    while tempo < deltat
        r = inicial + v * tempo
        
        plot(r(1), r(2), 'ro', 'Markersize', 28 * R, 'MarkerFaceColor', 'b')
    
        rectangle('Position', [0 0 a b], 'EdgeColor', 'r')
        axis square equal;
        
        pause(dt / 100)
        
        tempo = tempo + dt
    end
end

