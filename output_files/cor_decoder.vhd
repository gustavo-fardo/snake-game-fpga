library IEEE;
use  IEEE.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;

-- Mapeia valores RGB para o driver VGA de acordo com o valor em 2 bits de entrada
-- 00 => Fundo => Preto
-- 01 => Cobra => Verde
-- 10 => Fruta => Vermelho
-- 11 => Valor inesperado (erro) => Roxo

entity CorDecoder is
	generic(
		COR_BITS : in natural := 4
	);
   port( 
      valor_pixel : in std_logic_vector (1 downto 0);
		valor_verm : out std_logic_vector (COR_BITS-1 downto 0);
		valor_verde : out std_logic_vector (COR_BITS-1 downto 0);
		valor_azul : out std_logic_vector (COR_BITS-1 downto 0)
 	);
end entity CorDecoder;

architecture comportamento of CorDecoder is	

 -- Componente de cor zerada
constant zero : std_logic_vector (COR_BITS-1 downto 0) := std_logic_vector(to_unsigned(0, COR_BITS));
-- Componente de cor completa
constant full : std_logic_vector (COR_BITS-1 downto 0) := std_logic_vector(to_unsigned((2**COR_BITS-1), COR_BITS));
-- Componente cor parcial
constant part : std_logic_vector (COR_BITS-1 downto 0) := std_logic_vector(to_unsigned(8, COR_BITS));

begin
		process(valor_pixel)
		begin
			if valor_pixel = "00" then 	-- Fundo
				valor_verm <= zero;
				valor_verde <= part;
				valor_azul <= zero;
			elsif valor_pixel = "01" then -- Cobra
				valor_verm <= zero;
				valor_verde <= full;
				valor_azul <= zero;
			elsif valor_pixel = "10" then -- Fruta
				valor_verm <= full;
				valor_verde <= zero;
				valor_azul <= zero;
			else 									-- Valor outOfBounds
				valor_verm <= zero;
				valor_verde <= zero;
				valor_azul <= zero;
			end if;
		
		end process;
		--	

end comportamento;
