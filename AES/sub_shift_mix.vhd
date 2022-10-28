 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity sub_shift_mix is 
    port(
    tmp           : in std_logic_vector(127 downto 0) ;
    mix_counter   : in std_logic_vector(3 downto 0)  ;
	after_add_rounds : out std_logic_vector(127 downto 0)

	
	
    
    
    
    );
    
    
end entity; 


architecture arch of sub_shift_mix is-----------------SUB BYTES-----------

signal tmp_1 : std_logic_vector(127 downto 0);
signal tmp_2 : std_logic_vector(127 downto 0);

 signal   A0xDI     :  std_logic_vector(7 downto 0);
 signal   A1xDI     :  std_logic_vector(7 downto 0);
 signal   A2xDI     :  std_logic_vector(7 downto 0);
 signal   A3xDI     :  std_logic_vector(7 downto 0);
 
 signal   Q0xDI     :  std_logic_vector(7 downto 0);
 signal   Q1xDI     :  std_logic_vector(7 downto 0);
 signal   Q2xDI     :  std_logic_vector(7 downto 0);
 signal   Q3xDI     :  std_logic_vector(7 downto 0);
 
 signal   W0xDI     :  std_logic_vector(7 downto 0);
 signal   W1xDI     :  std_logic_vector(7 downto 0);
 signal   W2xDI     :  std_logic_vector(7 downto 0);
 signal   W3xDI     :  std_logic_vector(7 downto 0);
 
 signal   E0xDI     :  std_logic_vector(7 downto 0);
 signal   E1xDI     :  std_logic_vector(7 downto 0);
 signal   E2xDI     :  std_logic_vector(7 downto 0);
 signal   E3xDI     :  std_logic_vector(7 downto 0);

 -----------------------------------------
 -----------------------------------------
 -----------------------------------------

 signal B0xDO     :  std_logic_vector(7 downto 0);  
 signal B1xDO     :  std_logic_vector(7 downto 0);  
 signal B2xDO     :  std_logic_vector(7 downto 0);  
 signal B3xDO     :  std_logic_vector(7 downto 0);  
 
 signal Q0xDO     :  std_logic_vector(7 downto 0);  
 signal Q1xDO     :  std_logic_vector(7 downto 0);  
 signal Q2xDO     :  std_logic_vector(7 downto 0);  
 signal Q3xDO     :  std_logic_vector(7 downto 0);  
 
 signal W0xDO     :  std_logic_vector(7 downto 0);  
 signal W1xDO     :  std_logic_vector(7 downto 0);  
 signal W2xDO     :  std_logic_vector(7 downto 0);  
 signal W3xDO     :  std_logic_vector(7 downto 0);  
 
 signal E0xDO     :  std_logic_vector(7 downto 0);  
 signal E1xDO     :  std_logic_vector(7 downto 0);  
 signal E2xDO     :  std_logic_vector(7 downto 0);  
 signal E3xDO     :  std_logic_vector(7 downto 0);  
 




TYPE sBoxArray IS ARRAY (NATURAL RANGE 0 TO 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT sBox : sBoxArray := (
        x"63", x"7c", x"77", x"7b", x"f2", x"6b", x"6f", x"c5", x"30", x"01", x"67", x"2b", x"fe", x"d7", x"ab", x"76",
        x"ca", x"82", x"c9", x"7d", x"fa", x"59", x"47", x"f0", x"ad", x"d4", x"a2", x"af", x"9c", x"a4", x"72", x"c0",
        x"b7", x"fd", x"93", x"26", x"36", x"3f", x"f7", x"cc", x"34", x"a5", x"e5", x"f1", x"71", x"d8", x"31", x"15",
        x"04", x"c7", x"23", x"c3", x"18", x"96", x"05", x"9a", x"07", x"12", x"80", x"e2", x"eb", x"27", x"b2", x"75",
        x"09", x"83", x"2c", x"1a", x"1b", x"6e", x"5a", x"a0", x"52", x"3b", x"d6", x"b3", x"29", x"e3", x"2f", x"84",
        x"53", x"d1", x"00", x"ed", x"20", x"fc", x"b1", x"5b", x"6a", x"cb", x"be", x"39", x"4a", x"4c", x"58", x"cf",
        x"d0", x"ef", x"aa", x"fb", x"43", x"4d", x"33", x"85", x"45", x"f9", x"02", x"7f", x"50", x"3c", x"9f", x"a8",
        x"51", x"a3", x"40", x"8f", x"92", x"9d", x"38", x"f5", x"bc", x"b6", x"da", x"21", x"10", x"ff", x"f3", x"d2",
        x"cd", x"0c", x"13", x"ec", x"5f", x"97", x"44", x"17", x"c4", x"a7", x"7e", x"3d", x"64", x"5d", x"19", x"73",
        x"60", x"81", x"4f", x"dc", x"22", x"2a", x"90", x"88", x"46", x"ee", x"b8", x"14", x"de", x"5e", x"0b", x"db",
        x"e0", x"32", x"3a", x"0a", x"49", x"06", x"24", x"5c", x"c2", x"d3", x"ac", x"62", x"91", x"95", x"e4", x"79",
        x"e7", x"c8", x"37", x"6d", x"8d", x"d5", x"4e", x"a9", x"6c", x"56", x"f4", x"ea", x"65", x"7a", x"ae", x"08",
        x"ba", x"78", x"25", x"2e", x"1c", x"a6", x"b4", x"c6", x"e8", x"dd", x"74", x"1f", x"4b", x"bd", x"8b", x"8a",
        x"70", x"3e", x"b5", x"66", x"48", x"03", x"f6", x"0e", x"61", x"35", x"57", x"b9", x"86", x"c1", x"1d", x"9e",
        x"e1", x"f8", x"98", x"11", x"69", x"d9", x"8e", x"94", x"9b", x"1e", x"87", x"e9", x"ce", x"55", x"28", x"df",
        x"8c", x"a1", x"89", x"0d", x"bf", x"e6", x"42", x"68", x"41", x"99", x"2d", x"0f", x"b0", x"54", x"bb", x"16"
    );
    

signal tmp_sub_bytes : std_logic_vector(127 downto 0) := (others => 'Z') ;


		  
begin	 
         tmp_sub_bytes (7 downto 0)     <=      sBox(to_integer(unsigned(tmp(7 downto 0)    ))); -- SUB BYTES --
         tmp_sub_bytes (15 downto 8)    <=      sBox(to_integer(unsigned(tmp(15 downto 8)   )));
         tmp_sub_bytes (23 downto 16)   <=      sBox(to_integer(unsigned(tmp(23 downto 16)  )));
         tmp_sub_bytes (31 downto 24)   <=      sBox(to_integer(unsigned(tmp(31 downto 24)  )));
         tmp_sub_bytes (39 downto 32)   <=      sBox(to_integer(unsigned(tmp(39 downto 32)  )));
         tmp_sub_bytes (47 downto 40)   <=      sBox(to_integer(unsigned(tmp(47 downto 40)  )));
         tmp_sub_bytes (55 downto 48)   <=      sBox(to_integer(unsigned(tmp(55 downto 48)  )));
         tmp_sub_bytes (63 downto 56)   <=      sBox(to_integer(unsigned(tmp(63 downto 56)  )));
         tmp_sub_bytes (71 downto 64)   <=      sBox(to_integer(unsigned(tmp(71 downto 64)  )));
         tmp_sub_bytes (79 downto 72)   <=      sBox(to_integer(unsigned(tmp(79 downto 72)  )));
         tmp_sub_bytes (87 downto 80)   <=      sBox(to_integer(unsigned(tmp(87 downto 80)  )));
         tmp_sub_bytes (95 downto 88)   <=      sBox(to_integer(unsigned(tmp(95 downto 88)  )));
         tmp_sub_bytes (103 downto 96)  <=      sBox(to_integer(unsigned(tmp(103 downto 96) )));
         tmp_sub_bytes (111 downto 104) <=      sBox(to_integer(unsigned(tmp(111 downto 104))));
         tmp_sub_bytes (119 downto 112) <=      sBox(to_integer(unsigned(tmp(119 downto 112))));
         tmp_sub_bytes (127 downto 120) <=      sBox(to_integer(unsigned(tmp(127 downto 120))));
          
	     tmp_1 <= tmp_sub_bytes;
	     
	     tmp_2(103 downto 96)         <= tmp_1 (7 downto 0);    -- SHIFT ROWS --
	     tmp_2(79 downto 72)          <= tmp_1 (15 downto 8);
	     tmp_2(55 downto 48)          <= tmp_1 (23 downto 16);
	     tmp_2(31 downto 24)          <= tmp_1 (31 downto 24);
	     tmp_2(7 downto 0)            <= tmp_1 (39 downto 32);
	     tmp_2(111 downto 104)        <= tmp_1 (47 downto 40);
	     tmp_2(87 downto 80)          <= tmp_1 (55 downto 48);
	     tmp_2(63 downto 56)          <= tmp_1 (63 downto 56);
	     tmp_2(39 downto 32)          <= tmp_1 (71 downto 64);
	     tmp_2(15 downto 8)           <= tmp_1 (79 downto 72);
	     tmp_2(119 downto 112)        <= tmp_1 (87 downto 80);
	     tmp_2(95 downto 88)          <= tmp_1 (95 downto 88);
	     tmp_2(71 downto 64)          <= tmp_1 (103 downto 96);
	     tmp_2(47 downto 40)          <= tmp_1 (111 downto 104);
	     tmp_2(23 downto 16)          <= tmp_1 (119 downto 112);
	     tmp_2(127 downto 120)        <= tmp_1 (127 downto 120);
	     
	     
	A0xDI <= tmp_2(127 downto 120);  -- MIX COLUMNS --
	Q0xDI <=  tmp_2(95 downto 88) ;
	W0xDI <=  tmp_2(63 downto 56) ;
	E0xDI <=  tmp_2(31 downto 24) ;
			  
	
	A1xDI <= tmp_2(119 downto 112);
	Q1xDI <= tmp_2(87 downto 80 ) ;
	W1xDI <= tmp_2(55 downto 48)  ;
	E1xDI <= tmp_2(23 downto 16)  ;
	
	
	A2xDI <= tmp_2(111 downto 104);
	Q2xDI <= tmp_2(79 downto 72)  ;
	W2xDI <= tmp_2(47 downto 40);  
	E2xDI <= tmp_2(15 downto 8)  ;
	
	
	A3xDI <= tmp_2(103 downto 96)  ;
	Q3xDI <= tmp_2(71 downto 64)   ;
	W3xDI <= tmp_2(39 downto 32)   ;
	E3xDI <= tmp_2(7 downto 0)     ;









  -- Calculate all bytes at once
  mix_columns_p : process (A0xDI, A1xDI, A2xDI, A3xDI,Q0xDI,Q1xDI,Q2xDI,Q3xDI,W0xDI,W1xDI,W2xDI,W3xDI,E0xDI,E1xDI,E2xDI,E3xDI) is
    variable a0_mul_2 : std_logic_vector(7 downto 0);
	variable a1_mul_2 : std_logic_vector(7 downto 0);
	variable a2_mul_2 : std_logic_vector(7 downto 0);
	variable a3_mul_2 : std_logic_vector(7 downto 0);
	variable a0_mul_3 : std_logic_vector(7 downto 0);
	variable a1_mul_3 : std_logic_vector(7 downto 0);
	variable a2_mul_3 : std_logic_vector(7 downto 0);
	variable a3_mul_3 : std_logic_vector(7 downto 0);
	
	
	variable q0_mul_2 : std_logic_vector(7 downto 0);
	variable q1_mul_2 : std_logic_vector(7 downto 0);
	variable q2_mul_2 : std_logic_vector(7 downto 0);
	variable q3_mul_2 : std_logic_vector(7 downto 0);
	variable q0_mul_3 : std_logic_vector(7 downto 0);
	variable q1_mul_3 : std_logic_vector(7 downto 0);
	variable q2_mul_3 : std_logic_vector(7 downto 0);
	variable q3_mul_3 : std_logic_vector(7 downto 0);
	
	
	variable w0_mul_2 : std_logic_vector(7 downto 0);
	variable w1_mul_2 : std_logic_vector(7 downto 0);
	variable w2_mul_2 : std_logic_vector(7 downto 0);
	variable w3_mul_2 : std_logic_vector(7 downto 0);
	variable w0_mul_3 : std_logic_vector(7 downto 0);
	variable w1_mul_3 : std_logic_vector(7 downto 0);
	variable w2_mul_3 : std_logic_vector(7 downto 0);
	variable w3_mul_3 : std_logic_vector(7 downto 0);
	
	
	variable e0_mul_2 : std_logic_vector(7 downto 0);
	variable e1_mul_2 : std_logic_vector(7 downto 0);
	variable e2_mul_2 : std_logic_vector(7 downto 0);
	variable e3_mul_2 : std_logic_vector(7 downto 0);
	variable e0_mul_3 : std_logic_vector(7 downto 0);
	variable e1_mul_3 : std_logic_vector(7 downto 0);
	variable e2_mul_3 : std_logic_vector(7 downto 0);
	variable e3_mul_3 : std_logic_vector(7 downto 0);


  begin  -- process mix_columns_p
    -- 2*a0
    a0_mul_2(0) := A0xDI(7);
    a0_mul_2(1) := A0xDI(0) xor A0xDI(7);
    a0_mul_2(2) := A0xDI(1);
    a0_mul_2(3) := A0xDI(2) xor A0xDI(7);
    a0_mul_2(4) := A0xDI(3) xor A0xDI(7);
    a0_mul_2(5) := A0xDI(4);
    a0_mul_2(6) := A0xDI(5);
    a0_mul_2(7) := A0xDI(6);
	
	q0_mul_2(0) := Q0xDI(7);
    q0_mul_2(1) := Q0xDI(0) xor Q0xDI(7);
    q0_mul_2(2) := Q0xDI(1);
    q0_mul_2(3) := Q0xDI(2) xor Q0xDI(7);
    q0_mul_2(4) := Q0xDI(3) xor Q0xDI(7);
    q0_mul_2(5) := Q0xDI(4);
    q0_mul_2(6) := Q0xDI(5);
    q0_mul_2(7) := Q0xDI(6);
	
	w0_mul_2(0) := W0xDI(7);
    w0_mul_2(1) := W0xDI(0) xor W0xDI(7);
    w0_mul_2(2) := W0xDI(1);
    w0_mul_2(3) := W0xDI(2) xor W0xDI(7);
    w0_mul_2(4) := W0xDI(3) xor W0xDI(7);
    w0_mul_2(5) := W0xDI(4);
    w0_mul_2(6) := W0xDI(5);
    w0_mul_2(7) := W0xDI(6);
	
	e0_mul_2(0) := E0xDI(7);
    e0_mul_2(1) := E0xDI(0) xor E0xDI(7);
    e0_mul_2(2) := E0xDI(1);
    e0_mul_2(3) := E0xDI(2) xor E0xDI(7);
    e0_mul_2(4) := E0xDI(3) xor E0xDI(7);
    e0_mul_2(5) := E0xDI(4);
    e0_mul_2(6) := E0xDI(5);
    e0_mul_2(7) := E0xDI(6);

    -- 2*a1
    
	a1_mul_2(0) := A1xDI(7);
    a1_mul_2(1) := A1xDI(0) xor A1xDI(7);
    a1_mul_2(2) := A1xDI(1);
    a1_mul_2(3) := A1xDI(2) xor A1xDI(7);
    a1_mul_2(4) := A1xDI(3) xor A1xDI(7);
    a1_mul_2(5) := A1xDI(4);
    a1_mul_2(6) := A1xDI(5);
    a1_mul_2(7) := A1xDI(6);
	
	q1_mul_2(0) := Q1xDI(7);
    q1_mul_2(1) := Q1xDI(0) xor Q1xDI(7);
    q1_mul_2(2) := Q1xDI(1);
    q1_mul_2(3) := Q1xDI(2) xor Q1xDI(7);
    q1_mul_2(4) := Q1xDI(3) xor Q1xDI(7);
    q1_mul_2(5) := Q1xDI(4);
    q1_mul_2(6) := Q1xDI(5);
    q1_mul_2(7) := Q1xDI(6);
	
	w1_mul_2(0) := W1xDI(7);
    w1_mul_2(1) := W1xDI(0) xor W1xDI(7);
    w1_mul_2(2) := W1xDI(1);
    w1_mul_2(3) := W1xDI(2) xor W1xDI(7);
    w1_mul_2(4) := W1xDI(3) xor W1xDI(7);
    w1_mul_2(5) := W1xDI(4);
    w1_mul_2(6) := W1xDI(5);
    w1_mul_2(7) := W1xDI(6);
	
	e1_mul_2(0) := E1xDI(7);
    e1_mul_2(1) := E1xDI(0) xor E1xDI(7);
    e1_mul_2(2) := E1xDI(1);
    e1_mul_2(3) := E1xDI(2) xor E1xDI(7);
    e1_mul_2(4) := E1xDI(3) xor E1xDI(7);
    e1_mul_2(5) := E1xDI(4);
    e1_mul_2(6) := E1xDI(5);
    e1_mul_2(7) := E1xDI(6);

    -- 2*a2
    a2_mul_2(0) := A2xDI(7);
    a2_mul_2(1) := A2xDI(0) xor A2xDI(7);
    a2_mul_2(2) := A2xDI(1);
    a2_mul_2(3) := A2xDI(2) xor A2xDI(7);
    a2_mul_2(4) := A2xDI(3) xor A2xDI(7);
    a2_mul_2(5) := A2xDI(4);
    a2_mul_2(6) := A2xDI(5);
    a2_mul_2(7) := A2xDI(6);
	
	q2_mul_2(0) := Q2xDI(7);
    q2_mul_2(1) := Q2xDI(0) xor Q2xDI(7);
    q2_mul_2(2) := Q2xDI(1);
    q2_mul_2(3) := Q2xDI(2) xor Q2xDI(7);
    q2_mul_2(4) := Q2xDI(3) xor Q2xDI(7);
    q2_mul_2(5) := Q2xDI(4);
    q2_mul_2(6) := Q2xDI(5);
    q2_mul_2(7) := Q2xDI(6);
	
	w2_mul_2(0) := W2xDI(7);
    w2_mul_2(1) := W2xDI(0) xor W2xDI(7);
    w2_mul_2(2) := W2xDI(1);
    w2_mul_2(3) := W2xDI(2) xor W2xDI(7);
    w2_mul_2(4) := W2xDI(3) xor W2xDI(7);
    w2_mul_2(5) := W2xDI(4);
    w2_mul_2(6) := W2xDI(5);
    w2_mul_2(7) := W2xDI(6);
	
	e2_mul_2(0) := E2xDI(7);
    e2_mul_2(1) := E2xDI(0) xor E2xDI(7);
    e2_mul_2(2) := E2xDI(1);
    e2_mul_2(3) := E2xDI(2) xor E2xDI(7);
    e2_mul_2(4) := E2xDI(3) xor E2xDI(7);
    e2_mul_2(5) := E2xDI(4);
    e2_mul_2(6) := E2xDI(5);
    e2_mul_2(7) := E2xDI(6);

    -- 2*a3
    a3_mul_2(0) := A3xDI(7);
    a3_mul_2(1) := A3xDI(0) xor A3xDI(7);
    a3_mul_2(2) := A3xDI(1);
    a3_mul_2(3) := A3xDI(2) xor A3xDI(7);
    a3_mul_2(4) := A3xDI(3) xor A3xDI(7);
    a3_mul_2(5) := A3xDI(4);
    a3_mul_2(6) := A3xDI(5);
    a3_mul_2(7) := A3xDI(6);
	
	q3_mul_2(0) := Q3xDI(7);
    q3_mul_2(1) := Q3xDI(0) xor Q3xDI(7);
    q3_mul_2(2) := Q3xDI(1);
    q3_mul_2(3) := Q3xDI(2) xor Q3xDI(7);
    q3_mul_2(4) := Q3xDI(3) xor Q3xDI(7);
    q3_mul_2(5) := Q3xDI(4);
    q3_mul_2(6) := Q3xDI(5);
    q3_mul_2(7) := Q3xDI(6);
	
	w3_mul_2(0) := W3xDI(7);
    w3_mul_2(1) := W3xDI(0) xor W3xDI(7);
    w3_mul_2(2) := W3xDI(1);
    w3_mul_2(3) := W3xDI(2) xor W3xDI(7);
    w3_mul_2(4) := W3xDI(3) xor W3xDI(7);
    w3_mul_2(5) := W3xDI(4);
    w3_mul_2(6) := W3xDI(5);
    w3_mul_2(7) := W3xDI(6);
	
	e3_mul_2(0) := E3xDI(7);
    e3_mul_2(1) := E3xDI(0) xor E3xDI(7);
    e3_mul_2(2) := E3xDI(1);
    e3_mul_2(3) := E3xDI(2) xor E3xDI(7);
    e3_mul_2(4) := E3xDI(3) xor E3xDI(7);
    e3_mul_2(5) := E3xDI(4);
    e3_mul_2(6) := E3xDI(5);
    e3_mul_2(7) := E3xDI(6);

    -- 3*a0 = 2 * a0 + a0
    a0_mul_3 := a0_mul_2 xor A0xDI;
	q0_mul_3 := q0_mul_2 xor Q0xDI;
	w0_mul_3 := w0_mul_2 xor W0xDI;
	e0_mul_3 := e0_mul_2 xor E0xDI;
	

    -- 3*a1 = 2 * a1 + a1
    a1_mul_3 := a1_mul_2 xor A1xDI;
	q1_mul_3 := q1_mul_2 xor Q1xDI;
	w1_mul_3 := w1_mul_2 xor W1xDI;
	e1_mul_3 := e1_mul_2 xor E1xDI;

    -- 3*a2 = 2 * a2 + a2
    a2_mul_3 := a2_mul_2 xor A2xDI;
	q2_mul_3 := q2_mul_2 xor Q2xDI;
	w2_mul_3 := w2_mul_2 xor W2xDI;
	e2_mul_3 := e2_mul_2 xor E2xDI;
	
	
	
	

    -- 3*a3 = 2 * a3 + a3
    a3_mul_3 := a3_mul_2 xor A3xDI;
	q3_mul_3 := q3_mul_2 xor Q3xDI;
	w3_mul_3 := w3_mul_2 xor W3xDI;
	e3_mul_3 := e3_mul_2 xor E3xDI;
    
    -- b0 = 2*a0 + 3*a1 + 1*a2 + 1*a3
    B0xDO <= a0_mul_2 xor a1_mul_3 xor A2xDI    xor A3xDI;
	Q0xDO <= q0_mul_2 xor q1_mul_3 xor Q2xDI    xor Q3xDI;
	W0xDO <= w0_mul_2 xor w1_mul_3 xor W2xDI    xor W3xDI;
	E0xDO <= e0_mul_2 xor e1_mul_3 xor E2xDI    xor E3xDI;

    -- b1 = 1*a0 + 2*a1 + 3*a2 + 1*a3
    B1xDO <= A0xDI    xor a1_mul_2 xor a2_mul_3 xor A3xDI;
	Q1xDO <= Q0xDI    xor q1_mul_2 xor q2_mul_3 xor Q3xDI;
	W1xDO <= W0xDI    xor w1_mul_2 xor w2_mul_3 xor W3xDI;
	E1xDO <= E0xDI    xor e1_mul_2 xor e2_mul_3 xor E3xDI;
	   

    -- b2 = 1*a0 + 1*a1 + 2*a2 + 3*a3
    B2xDO <= A0xDI    xor A1xDI    xor a2_mul_2 xor a3_mul_3;
	Q2xDO <= Q0xDI    xor Q1xDI    xor q2_mul_2 xor q3_mul_3;
	W2xDO <= W0xDI    xor W1xDI    xor w2_mul_2 xor w3_mul_3;
	E2xDO <= E0xDI    xor E1xDI    xor e2_mul_2 xor e3_mul_3;

    -- b3 = 3*a0 + 1*a1 + 1*a2 + 2*a3
    B3xDO <= a0_mul_3 xor A1xDI    xor A2xDI    xor a3_mul_2;
	Q3xDO <= q0_mul_3 xor Q1xDI    xor Q2xDI    xor q3_mul_2;
	W3xDO <= w0_mul_3 xor W1xDI    xor W2xDI    xor w3_mul_2;
	E3xDO <= e0_mul_3 xor E1xDI    xor E2xDI    xor e3_mul_2;
    
    
   
    
     
    
    
    
    end process mix_columns_p;
    after_add_rounds <= tmp_2 when mix_counter = "1010"  else
                        B0xDO & B1xDO & B2xDO & B3xDO & Q0xDO & Q1xDO & Q2xDO & Q3xDO & W0xDO & W1xDO & W2xDO & W3xDO & E0xDO & E1xDO & E2xDO & E3xDO;
	
	     
	     
	     
end architecture;