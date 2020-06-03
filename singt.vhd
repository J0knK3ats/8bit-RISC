LIBRARY IEEE;  --正弦信号发生器源文件
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY SINGT IS
    PORT ( CLK  : IN STD_LOGIC;              --信号源时钟
            DOUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) );--8位波形数据输出
END;
ARCHITECTURE DACC OF SINGT IS
COMPONENT data_rom --调用波形数据存储器LPM_ROM文件：data_rom.vhd声明
   PORT(address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);--6位地址信号
	    inclock : IN STD_LOGIC ;--地址锁存时钟
	           q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)	);
END COMPONENT;
SIGNAL Q1 : STD_LOGIC_VECTOR (5 DOWNTO 0); --设定内部节点作为地址计数器
    BEGIN
PROCESS(CLK )                           --LPM_ROM地址发生器进程
    BEGIN
IF CLK'EVENT AND CLK = '1' THEN  Q1<=Q1+1; --Q1作为地址发生器计数器
END IF;
END PROCESS;
u1 : data_rom PORT MAP(address=>Q1, q => DOUT,inclock=>CLK);--例化
END; 
