#include <stdbool.h>
typedef enum NumType{
		NUM_INT,
		NUM_DOUBLE
	} NumType;
typedef struct Number{
	NumType type; // 0 -> int   1 -> double
	union{
		double double_val;
		int int_val;
	};
} Number;
Number intNumber(int a){
	Number r;
	r.type=NUM_INT;
	r.int_val=a;
	return r;
}
Number doubleNumber(double a){
	Number r;
	r.type=NUM_DOUBLE;
	r.double_val=a;
	return r;
}
Number addNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return intNumber(a.int_val+b.int_val);
		}else{ //NUM_DOUBLE
			return doubleNumber(a.int_val+b.double_val);
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return doubleNumber(a.double_val+b.int_val);
		}else{ //NUM_DOUBLE
			return doubleNumber(a.double_val+b.double_val);
		}
	}
}
Number subNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return intNumber(a.int_val-b.int_val);
		}else{ //NUM_DOUBLE
			return doubleNumber(a.int_val-b.double_val);
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return doubleNumber(a.double_val-b.int_val);
		}else{ //NUM_DOUBLE
			return doubleNumber(a.double_val-b.double_val);
		}
	}
}
Number mulNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return intNumber(a.int_val*b.int_val);
		}else{ //NUM_DOUBLE
			return doubleNumber(a.int_val*b.double_val);
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return doubleNumber(a.double_val*b.int_val);
		}else{ //NUM_DOUBLE
			return doubleNumber(a.double_val*b.double_val);
		}
	}
}
Number divNumber(Number a,Number b,const char ** msg){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			Number c;
			if (b.int_val==0){
				msg[0]="divided by zero";
			}else{
				c.type=NUM_INT;
				c.int_val=a.int_val/b.int_val;
			}
			return c;
		}else{ //NUM_DOUBLE
			Number c;
			c.type=NUM_DOUBLE;
			c.double_val=a.int_val/b.double_val;
			return c;
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			Number c;
			if (b.int_val==0){
				msg[0]="divided by zero";
			}else{
				c.type=NUM_DOUBLE;
				c.double_val=a.double_val/b.int_val;
			}
			return c;
		}else{ //NUM_DOUBLE
			Number c;
			c.type=NUM_DOUBLE;
			c.double_val=a.double_val/b.double_val;
			return c;
		}
	}
}
Number modNumber(Number a,Number b,const char ** msg){
	Number c;
	if (a.type!=NUM_INT || b.type!=NUM_INT){
		msg[0]="cannot use non-integer value in mod";
	}else{
		c.type=NUM_INT;
		c.int_val=a.int_val%b.int_val;
	}
	return c;
}
bool leNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return a.int_val<b.int_val;
		}else{ //NUM_DOUBLE
			return a.int_val<b.double_val;
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return a.double_val<b.int_val;
		}else{ //NUM_DOUBLE
			return a.double_val<b.double_val;
		}
	}
}
bool geNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return a.int_val>b.int_val;
		}else{ //NUM_DOUBLE
			return a.int_val>b.double_val;
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return a.double_val>b.int_val;
		}else{ //NUM_DOUBLE
			return a.double_val>b.double_val;
		}
	}
}
bool nleNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return a.int_val>=b.int_val;
		}else{ //NUM_DOUBLE
			return a.int_val>=b.double_val;
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return a.double_val>=b.int_val;
		}else{ //NUM_DOUBLE
			return a.double_val>=b.double_val;
		}
	}
}
bool ngeNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return a.int_val<=b.int_val;
		}else{ //NUM_DOUBLE
			return a.int_val<=b.double_val;
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return a.double_val<=b.int_val;
		}else{ //NUM_DOUBLE
			return a.double_val<=b.double_val;
		}
	}
}
bool eqNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return a.int_val==b.int_val;
		}else{ //NUM_DOUBLE
			return a.int_val==b.double_val;
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return a.double_val==b.int_val;
		}else{ //NUM_DOUBLE
			return a.double_val==b.double_val;
		}
	}
}
bool neqNumber(Number a,Number b){
	if (a.type==NUM_INT){
		if (b.type==NUM_INT){
			return a.int_val!=b.int_val;
		}else{ //NUM_DOUBLE
			return a.int_val!=b.double_val;
		}
	}else{ //NUM_DOUBLE
		if (b.type==NUM_INT){
			return a.double_val!=b.int_val;
		}else{ //NUM_DOUBLE
			return a.double_val!=b.double_val;
		}
	}
}
