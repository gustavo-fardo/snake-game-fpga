library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Realiza o debouncing de entrada Push Button

entity debouncer is
    Generic (
        CLK_FREQ_HZ  : natural := 50_000_000;
        DEBOUNCE_MS  : natural := 1
    );
    Port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        btn      : in  std_logic;
        btn_out  : out std_logic;
        btn_fall : out std_logic    -- saida falling-edge
    );
end debouncer;

architecture Behavioral of debouncer is

    constant DEBOUNCE_CYCLES : natural :=
        (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;

    signal btn_last     : std_logic;
    signal btn_current  : std_logic;
    signal debounce_cnt : natural range 0 to DEBOUNCE_CYCLES;
    signal reset_cnt    : std_logic;
    signal btn_out_reg  : std_logic := '1'; -- debounced value
    signal prev_out     : std_logic := '1'; -- previous debounced value

begin

	 -- Contador de debounce é resetado se o debounce perceber alteracao no valor de entrada
	 -- ou se a entrada de rst for ativada
    reset_cnt <= (btn_last xor btn_current) or rst;

    process(clk)
    begin
        if rising_edge(clk) then

            -- Armazenam o estado anterior e o estado atual do Push Button
            btn_last    <= btn_current;
            btn_current <= btn;

				
				-- Somente muda o valor percebido na saida quando atinge o numero 
				-- de ciclos necessarios em um estado, senao continua somando ou reseta
				-- 
            if reset_cnt = '1' then
                debounce_cnt <= 0;

            elsif debounce_cnt < DEBOUNCE_CYCLES then
                debounce_cnt <= debounce_cnt + 1;

            else
                
                btn_out_reg <= btn_last;
            end if;

            -- Deteccao de falling edge
            prev_out <= btn_out_reg;
				if (prev_out = '1' and btn_out_reg = '0') then
					btn_fall <= '1';
				else 
					btn_fall <='0';
				end if;

        end if;
    end process;
 
    btn_out <= btn_out_reg;

end Behavioral;
