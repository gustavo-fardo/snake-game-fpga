library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package log2bits is
    function bits_needed(n : natural) return natural;
end package;

package body log2bits is
    function bits_needed(n : natural) return natural is
        variable temp : natural := 1;
        variable b    : natural := 0;
    begin
        if n = 0 then
            return 0;
        end if;
        
        while temp < n loop
            temp := temp * 2;
            b    := b + 1;
        end loop;
        
        if b = 0 then
            return 1;
        else
            return b;
        end if;
    end function;
end package body;
