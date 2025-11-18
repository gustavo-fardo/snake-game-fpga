-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "11/17/2025 16:45:01"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          snake-game-fpga
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY snake-game-fpga_vhd_vec_tst IS
END snake-game-fpga_vhd_vec_tst;
ARCHITECTURE snake-game-fpga_arch OF snake-game-fpga_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL KEY0 : STD_LOGIC;
SIGNAL KEY1 : STD_LOGIC;
SIGNAL out : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
COMPONENT snake-game-fpga
	PORT (
	clk : IN STD_LOGIC;
	KEY0 : IN STD_LOGIC;
	KEY1 : IN STD_LOGIC;
	\out\ : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	reset : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : snake-game-fpga
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	KEY0 => KEY0,
	KEY1 => KEY1,
	\out\ => out,
	reset => reset
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
	clk <= '0';
WAIT;
END PROCESS t_prcs_clk;

-- KEY0
t_prcs_KEY0: PROCESS
BEGIN
	KEY0 <= '0';
WAIT;
END PROCESS t_prcs_KEY0;

-- KEY1
t_prcs_KEY1: PROCESS
BEGIN
	KEY1 <= '0';
WAIT;
END PROCESS t_prcs_KEY1;

-- reset
t_prcs_reset: PROCESS
BEGIN
	reset <= '0';
WAIT;
END PROCESS t_prcs_reset;
END snake-game-fpga_arch;
