library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Gera 2 coordenadas pseudoaleatorias para a localizacao da fruta

entity GeradorFruta is
	 Generic (
		  M : natural := 20; -- Coordenada máxima no eixo X
		  N : natural := 20 -- Coordenada máxima no eixo Y
	 );
    Port (
		  enable : in std_logic;
		  clk_gera : in std_logic;
		  fruta_x : out std_logic_vector(3 downto 0);
		  fruta_y : out std_logic_vector(3 downto 0)
    );
end GeradorFruta;

architecture Behavioral of GeradorFruta is

    --  Seeds
    signal lfsr_x : unsigned(15 downto 0) := x"ACE1";
    signal lfsr_y : unsigned(15 downto 0) := x"BEEF";

begin

    process(clk_gera)
        variable feedback_x : std_logic;
        variable feedback_y : std_logic;
        variable rnd_x      : integer;
        variable rnd_y      : integer;
    begin
        if rising_edge(clk_gera) and enable = '1' then

				-- Utiliza Shift Registers de Feedback Linear para a geração de inteiros
				-- pseudoaleatorios a partir de seeds
				
				-- Proximo inteiro gerado é resultado da operacao AND dos 15 LSB com o
				-- resultado de um XOR entre os 4 MSB
				
            feedback_x := lfsr_x(15) xor lfsr_x(13) xor lfsr_x(12) xor lfsr_x(10);
            lfsr_x     <= lfsr_x(14 downto 0) & feedback_x;
				
            feedback_y := lfsr_y(15) xor lfsr_y(13) xor lfsr_y(12) xor lfsr_y(10);
            lfsr_y     <= lfsr_y(14 downto 0) & feedback_y;

				-- Calcula o resto para que o inteiro gerado seja entre 0 e M-1 ou N-1
				
            rnd_x := to_integer(lfsr_x) mod M;  -- 0 to M-1
            rnd_y := to_integer(lfsr_y) mod N;  -- 0 to N-1

            fruta_x <= std_logic_vector(to_unsigned(rnd_x, fruta_x'length));
            fruta_y <= std_logic_vector(to_unsigned(rnd_y, fruta_y'length));

        end if;
    end process;

end Behavioral;
