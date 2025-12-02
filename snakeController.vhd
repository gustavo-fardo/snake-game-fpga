library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package snakePackage is
    type matrix is array(0 to 255) of integer range -1 to 255;
    function getIndex(row: integer; col: integer) return integer;
end snakePackage;

package body snakePackage is
    function getIndex(row: integer; col: integer) return integer is
    begin
        return row * 16 + col;
    end function;
end snakePackage;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.snakePackage.all;

entity snakeController is
    port(
        reset: in std_logic;
        clk: in std_logic;
        frameTick: in std_logic;

        -- 00 - cima
        -- 01 - direita
        -- 10 - baixo
        -- 11 - esquerda
        sentido: in std_logic_vector(1 downto 0);

        -- coordenadas da comida a ser gerada no tabuleiro
        comidaX: in unsigned(3 downto 0);
        comidaY: in unsigned(3 downto 0);

        -- coordenadas do tabuleiro sendo pedida pelo driver vga
        pixelX: in unsigned(3 downto 0);
        pixelY: in unsigned(3 downto 0);
		  outOfBounds: in std_logic;

        -- tamanho da cobra/pontuacao para ser exibido nos displays
        tamanho: out std_logic_vector(7 downto 0);

        -- 00 - vazio
        -- 01 - segmento cobra
        -- 10 - comida
        pixelOut: out std_logic_vector(1 downto 0)
    );
end snakeController;

architecture snakeController of snakeController is

signal tamanhoSignal : integer range 0 to 255 := 1;
signal snakeMatrix : matrix := (others => 0);
signal headX : integer range 0 to 15 := 8;
signal headY : integer range 0 to 15 := 7;

begin

-- reset, geracao de comida e movimentacao da cobra
process (clk)
    variable newHeadX : integer range -1 to 16;
    variable newHeadY : integer range -1 to 16;
    variable prevFrameTick : std_logic := '0';
    variable needFood : boolean := true;
    variable stopGame : boolean := false;
    variable idx : integer range 0 to 255;
	 variable tamanhoVar: integer range 0 to 255 := 1;
begin
    if rising_edge(clk) then
		  tamanhoSignal <= tamanhoVar;
        -- reset sincrono
        if reset = '1' then
            -- reseta tamanho
            tamanhoVar := 1;
            -- reseta posicao da cabeca
            headX <= 12;
            headY <= 7;
            -- gera sinal para criar comida e reseta matriz
            needFood := false;
            stopGame := false;
            snakeMatrix <= (others => 0);
            snakeMatrix(getIndex(headY, headX)) <= 1;
            snakeMatrix(getIndex(5, 5)) <= -1;
            prevFrameTick := '0';
        else

        -- geracao de comida
        if needFood then
            idx := getIndex(to_integer(comidaY), to_integer(comidaX));
            if snakeMatrix(idx) = 0 then
                snakeMatrix(idx) <= -1;  -- coloca comida na matriz
                needFood := false;
				end if;
        end if;

        -- detecta risignEdge do clock de frame
        if (prevFrameTick = '0') and (frameTick = '1') and (stopGame = false) then
            -- calcula a nova posicao da cabeca
            case sentido is
                when "00" =>  -- cima
                    newHeadX := headX;
                    newHeadY := headY - 1;
                when "01" =>  -- direita
                    newHeadX := headX + 1;
                    newHeadY := headY;
                when "10" =>  -- baixo
                    newHeadX := headX;
                    newHeadY := headY + 1;
                when others =>  -- esquerda
                    newHeadX := headX - 1;
                    newHeadY := headY;
            end case;

            -- se a nova posicao for parede ou corpo da cobra, para o jogo
            if (newHeadX < 0) or (newHeadX > 15) or (newHeadY < 0) or (newHeadY > 15) then
                stopGame := true;
            elsif (snakeMatrix(getIndex(newHeadY, newHeadX)) > 0) then
                stopGame := true;
            end if;

            if not stopGame then
					 -- se a nova posicao for comida
                if snakeMatrix(getIndex(newHeadY, newHeadX)) = -1 then
                    tamanhoVar := tamanhoVar + 1;
                    needFood := true; -- sinaliza para criar nova comida
                -- se nao for comida, decrementa os valores na matriz, movendo a cobra
                else
                    for i in 0 to 255 loop
                        if snakeMatrix(i) > 0 then
                            snakeMatrix(i) <= snakeMatrix(i) - 1;
                        end if;
                    end loop;
                end if;

                -- atualiza a posicao da cabeca na matriz
                snakeMatrix(getIndex(newHeadY, newHeadX)) <= tamanhoVar;  -- adiciona a cabeca
                headX <= newHeadX;
                headY <= newHeadY;
            end if;
        end if;

        -- atualiza o prevFrameTick
        prevFrameTick := frameTick;
        end if;
    end if;
end process;

tamanho <= std_logic_vector(to_unsigned(tamanhoSignal, 8));

-- determina o valor do pixel a ser exibido
process(clk)
    variable idx : integer range 0 to 255;
begin
    if rising_edge(clk) then
		  if outOfBounds = '1' then
				pixelOut <= "11"; -- out of bounds color
		  else
				idx := getIndex(to_integer(pixelY), to_integer(pixelX));
			   if snakeMatrix(idx) > 0 then
				 	pixelOut <= "01";  -- segmento da cobra
			   elsif snakeMatrix(idx) = -1 then
			 		pixelOut <= "10";  -- comida
			   else
					pixelOut <= "00";  -- vazio
			   end if;
		  end if;
    end if;
end process;

end snakeController;