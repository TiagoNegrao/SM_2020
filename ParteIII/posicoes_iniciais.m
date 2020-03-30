function [r,erro]=posicoes_iniciais(a,b,R,np)
    assert(np > 0 && np <= 50, 'Evitar números de particulas maiores que 50');

    erro=false;
    ntentativas_max=100;
    for i=1:np
        r(1,i)=rand(1)*(a-2*R)+R; r(2,i)=rand(1)*(b-2*R)+R;
        %calculo da distancia ï¿½s outras partï¿½culas
        if i>1
            r12=r(:,1:i-1)-repmat(r(:,i),1,i-1);
            dij=sqrt(r12(1,:).^2+r12(2,:).^2);
            ij=find(dij<2*R); % para garantir que nao existem particulas sobrepostas
            ntentativas=0;
            while numel(ij) && ntentativas<= ntentativas_max
                ntentativas=ntentativas+1;
                r(1,i)=rand(1)*(a-2*R)+R; r(2,i)=rand(1)*(b-2*R)+R;
                r12=r(:,1:i-1)-repmat(r(:,i),1,i-1);
                dij=sqrt(r12(1,:).^2+r12(2,:).^2);
                ij=find(dij<2*R);
            end
            if ntentativas > ntentativas_max
                fprintf(1,'Numero de particulas demasiado elevado\n')
                erro=true;
                return
            end
        end
    end
end
