module MusicSheet
(
    input [9:0] number, 
	output reg [19:0] note,        //max 32 different musical notes
	output reg [4:0] duration,
	output reg done
);
    parameter   QUARTER = 5'b00010; //2 Hz
    parameter	HALF = 5'b00100;
    parameter	ONE = 2* HALF;
    parameter	TWO = 2* ONE;
    parameter	FOUR = 2* TWO;
    parameter
        B4  =   50000000/493.8833,
        C5S =   50000000/554.3653,
        D5S =   50000000/622.2540,
        E5  =   50000000/659.2551,
        F5S =   50000000/739.9888,
        G5S =   50000000/830.6094,
        A5S =   50000000/932.3275,
        B5  =   50000000/987.7666,
        SP  =   1;  
 
    always @ (number) begin
        case(number) //Row Row Row your boat
            0:      begin note = B5;    duration = QUARTER; done = 0;	end    //first measure
            1:      begin note = B4;    duration = QUARTER;	done = 0;   end
            2:      begin note = B5;    duration = QUARTER;	done = 0;   end
            3:      begin note = A5S;   duration = QUARTER;	done = 0;   end
            4:      begin note = B4;    duration = QUARTER;	done = 0;   end
            5:      begin note = A5S;   duration = QUARTER;	done = 0;   end
            6:      begin note = F5S;   duration = ONE;	    done = 0;   end
            7:      begin note = F5S;   duration = HALF;	done = 0;   end
            8:      begin note = D5S;   duration = HALF;	done = 0;   end
            9:      begin note = C5S;   duration = QUARTER;	done = 0;   end
            10:     begin note = B4;    duration = QUARTER;	done = 0;   end
            
            11:     begin note = B5;    duration = QUARTER;	done = 0;   end     //second measure
            12:     begin note = B4;    duration = QUARTER;	done = 0;   end
            13:     begin note = B5;    duration = QUARTER; done = 0;   end
            14:     begin note = A5S;   duration = QUARTER; done = 0;   end
            15:     begin note = B4;    duration = QUARTER; done = 0;   end
            16:     begin note = A5S;   duration = QUARTER; done = 0;   end
            17:     begin note = F5S;   duration = QUARTER; done = 0;   end
            18:     begin note = B4;    duration = QUARTER; done = 0;   end
            19:     begin note = F5S;   duration = QUARTER; done = 0;   end
            20:     begin note = B4;    duration = QUARTER; done = 0;   end
            21:     begin note = F5S;   duration = QUARTER; done = 0;   end
            22:     begin note = B4;    duration = QUARTER; done = 0;   end
            23:     begin note = D5S;   duration = QUARTER; done = 0;   end
            24:     begin note = E5;    duration = QUARTER; done = 0;   end
            25:     begin note = D5S;   duration = QUARTER; done = 0;   end
            26:     begin note = B4;    duration = QUARTER; done = 0;   end
            
            27:     begin note = B5;    duration = QUARTER;	done = 0;   end    //third measure
            28:     begin note = B4;    duration = QUARTER; done = 0;   end
            29:     begin note = B5;    duration = QUARTER; done = 0;   end
            30:     begin note = A5S;   duration = QUARTER; done = 0;   end
            31:     begin note = B4;    duration = QUARTER; done = 0;   end
            32:     begin note = A5S;   duration = QUARTER; done = 0;   end
            33:     begin note = F5S;   duration = ONE;     done = 0;   end
            34:     begin note = F5S;   duration = HALF;    done = 0;   end
            35:     begin note = D5S;   duration = HALF;    done = 0;   end
            36:     begin note = C5S;   duration = QUARTER; done = 0;   end
            37:     begin note = B4;    duration = QUARTER; done = 0;   end
           
            38:     begin note = D5S;   duration = QUARTER; done = 0;   end     //fourth measure
            39:     begin note = C5S;   duration = QUARTER; done = 0;   end
            40:     begin note = B4;    duration = QUARTER; done = 0;   end
            41:     begin note = D5S;   duration = QUARTER; done = 0;   end
            42:     begin note = C5S;   duration = QUARTER; done = 0;   end
            43:     begin note = B4;    duration = QUARTER; done = 0;   end
            44:     begin note = F5S;   duration = ONE;	    done = 0;   end
            45:     begin note = F5S;   duration = HALF;    done = 0;   end
            46:     begin note = C5S;   duration = ONE;	    done = 0;   end
            
            47:     begin note = B4;    duration = QUARTER; done = 1;   end
            default:begin note = B4; duration = FOUR; 	end
        endcase
    end
endmodule
