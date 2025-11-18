library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package snakePackage is
type matrix is array(0 to 15, 0 to 15) of integer;
end snakePackage;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.snakePackage.all;

entity snakeController is
port(
reset: in std_logic;

-- 00 - cima
-- 01 - direita
-- 10 - baixo
-- 11 - esquerda
sentido: in std_logic_vector(1 downto 0);

-- coordenadas da comida a ser gerada no tabuleiro
comidaPronta: in std_logic;
comidaX: in unsigned(3 downto 0);
comidaY: in unsigned(3 downto 0);

-- coordenadas do tabuleiro sendo pedida pelo driver vga
pixelX: in unsigned(3 downto 0);
pixelY: in unsigned(3 downto 0);

-- sinal a ser emitido quando precisa gerar uma nova coordenada pra comida
sinalComida: out std_logic;

-- tamanho da cobra/pontuacao para ser exibido nos displays
tamanho: out std_logic_vector(7 downto 0);

-- 00 - vazio
-- 01 - segmento cobra
-- 10 - comida
pixelOut: out std_logic_vector(1 downto 0)
);
end snakeController;

architecture snakeController of snakeController is
shared variable snakeMatrix : matrix :=
(
(1,1,1,1,0,0,0,0,2,2,2,2,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
);
begin

-- gera uma comida nas coordenadas dadas pelas entadas
process (comidaX, comidaY)
begin
end process;

pixelOut <= std_logic_vector(to_unsigned(
snakeMatrix(
to_integer(pixelY),
to_integer(pixelX)
), 2));

end snakeController;