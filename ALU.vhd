LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
    PORT (
        S  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0 );
        A  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        B  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        F  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		COUT  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        M  : IN  STD_LOGIC;
        CN : IN  STD_LOGIC;
        CO,FZ: OUT STD_LOGIC   );
END ALU;

ARCHITECTURE alu OF ALU IS
SIGNAL ALU_A : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ALU_B : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ALU_RESULT : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
  ALU_A <= '0' & A ;  ALU_B <= '0' & B ;  
  PROCESS(M,CN,ALU_A,ALU_B)
   BEGIN
    CASE S  IS
    	  WHEN "0000" =>  IF M='0' THEN ALU_RESULT<=ALU_A + CN                           ; ELSE  ALU_RESULT<=NOT ALU_A;                END IF;
        WHEN "0001" =>  IF M='0' THEN ALU_RESULT<=(ALU_A or ALU_B) + CN                ; ELSE  ALU_RESULT<=NOT(ALU_A OR ALU_B);         END IF;
        WHEN "0010" =>  IF M='0' THEN ALU_RESULT<=(ALU_A or (NOT ALU_B))+ CN           ; ELSE  ALU_RESULT<=(NOT ALU_A) AND ALU_B;       END IF;
        WHEN "0011" =>  IF M='0' THEN ALU_RESULT<= "000000000" - CN                    ; ELSE  ALU_RESULT<="000000000";           END IF;
        WHEN "0100" =>  IF M='0' THEN ALU_RESULT<=ALU_A+(ALU_A AND NOT ALU_B)+ CN      ; ELSE  ALU_RESULT<=NOT (ALU_A AND ALU_B);       END IF;
        WHEN "0101" =>  IF M='0' THEN ALU_RESULT<=(ALU_A or ALU_B)+(ALU_A AND NOT ALU_B)+CN  ; ELSE  ALU_RESULT<=NOT ALU_B;                END IF;
        WHEN "0110" =>  IF M='0' THEN ALU_RESULT<=(ALU_A - ALU_B) - CN                 ; ELSE  ALU_RESULT<=ALU_A XOR ALU_B;             END IF;
        WHEN "0111" =>  IF M='0' THEN ALU_RESULT<=(ALU_A or (NOT ALU_B)) - CN          ; ELSE  ALU_RESULT<=ALU_A and (NOT ALU_B);       END IF;
        WHEN "1000" =>  IF M='0' THEN ALU_RESULT<=ALU_A + (ALU_A AND ALU_B)+CN         ; ELSE  ALU_RESULT<=(NOT ALU_A)and ALU_B;        END IF;
        WHEN "1001" =>  IF M='0' THEN ALU_RESULT<=ALU_A + ALU_B + CN                   ; ELSE  ALU_RESULT<=NOT(ALU_A XOR ALU_B);        END IF;
        WHEN "1010" =>  IF M='0' THEN ALU_RESULT<=(ALU_A or(NOT ALU_B))+(ALU_A AND ALU_B)+CN ; ELSE  ALU_RESULT<=ALU_B;                    END IF;
        WHEN "1011" =>  IF M='0' THEN ALU_RESULT<=(ALU_A AND ALU_B)- CN                ; ELSE  ALU_RESULT<=ALU_A AND ALU_B;             END IF;
        WHEN "1100" =>  IF M='0' THEN ALU_RESULT<=(ALU_A + ALU_A) + CN                 ; ELSE  ALU_RESULT<= "000000001";          END IF;
        WHEN "1101" =>  IF M='0' THEN ALU_RESULT<=(ALU_A or ALU_B) + ALU_A + CN        ; ELSE  ALU_RESULT<=ALU_A OR (NOT ALU_B);        END IF;
        WHEN "1110" =>  IF M='0' THEN ALU_RESULT<=((ALU_A or (NOT ALU_B)) +ALU_A) + CN ; ELSE  ALU_RESULT<=ALU_A OR ALU_B;              END IF;
        WHEN "1111" =>  IF M='0' THEN ALU_RESULT<=ALU_A - CN                           ; ELSE  ALU_RESULT<=ALU_A ;                   END IF;
        WHEN OTHERS  => ALU_RESULT<= "000000000" ;  
    	END CASE;
  	IF(ALU_A=ALU_B) THEN FZ<='0';END IF;
	END PROCESS;
 F<= ALU_RESULT(7 DOWNTO 0) ;   
 CO <= ALU_RESULT(8) ;
 COUT<="0000" WHEN ALU_RESULT(8)='0' ELSE "0001";

END alu;
