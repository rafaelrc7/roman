%{
	#include <stdio.h>

	void yyerror(double *result, const char *err_msg);
	int yylex(void);

	#define ONE_TWELFTH	(1.0/12.0)
%}

%parse-param {double *result}
%define api.value.type {double}

%token 'I' 'V' 'X' 'L' 'C' 'D' 'M' '(' ')' '|' 'S' '.' '-'
%token THOUSAND FIVE_HUNDRED
%token NULLA SILIQUA SCRIPULUM DIMIDIA_SEXTULA SEXTULA SICILICUS BINAE_SEXTULAE SEMUNCIA SESCUNCIA
%%

roman			:	numeral							{ *result = $1;	}
				;

numeral			:	overVinculum boxVinculum group	{ $$ = $1 + $2 + $3;	}
				|	NULLA							{ $$ = 0;				}
				;

overVinculum	:	%empty							{ $$ = 0;				}
				|	'-' group '-'					{ $$ = $2 * 1000;		}
				;

boxVinculum		:	%empty							{ $$ = 0;				}
				|	'|' group '|'					{ $$ = $2 * 100000;		}
				;

smallFractions	:	%empty							{ $$ = 0 * ONE_TWELFTH;	}
				|	'.'								{ $$ = 1 * ONE_TWELFTH;	}
				|	'.' '.'							{ $$ = 2 * ONE_TWELFTH;	}
				|	'.' '.' '.'						{ $$ = 3 * ONE_TWELFTH;	}
				|	'.' '.' '.' '.'					{ $$ = 4 * ONE_TWELFTH;	}
				|	'.' '.' '.' '.' '.'				{ $$ = 5 * ONE_TWELFTH;	}
				;

fractions		:	%empty							{ $$ = 0;				}
				|	'S' smallFractions				{ $$ = 1.0/2.0 + $2;	}
				|	SILIQUA							{ $$ = 1.0/1728;		}
				|	SCRIPULUM						{ $$ = 1.0/288;			}
				|	DIMIDIA_SEXTULA					{ $$ = 1.0/144;			}
				|	SEXTULA							{ $$ = 1.0/72;			}
				|	SICILICUS						{ $$ = 1.0/48;			}
				|	BINAE_SEXTULAE					{ $$ = 1.0/36;			}
				|	SEMUNCIA						{ $$ = 1.0/24;			}
				|	SESCUNCIA						{ $$ = 1.0/8;			}
				;

smallUnits		:	%empty							{ $$ = 0 * 1;			}
				|	'I'								{ $$ = 1 * 1;			}
				|	'I' 'I'							{ $$ = 2 * 1;			}
				|	'I' 'I' 'I'						{ $$ = 3 * 1;			}
				;

units			:	smallUnits						{ $$ = $1;				}
				|	'I' 'V'							{ $$ = 5 - 1;			}
				|	'V' smallUnits					{ $$ = 5 + $2;			}
				|	'I' 'X'							{ $$ = 10 - 1;			}
				;

smallTens		:	%empty							{ $$ = 0 * 10;			}
				|	'X'								{ $$ = 1 * 10;			}
				|	'X' 'X'							{ $$ = 2 * 10;			}
				|	'X' 'X' 'X'						{ $$ = 3 * 10;			}
				;

tens			:	smallTens						{ $$ = $1;				}
				|	'X'	'L'							{ $$ = 50 - 10;			}
				|	'L' smallTens					{ $$ = 50 + $2;			}
				|	'X' 'C'							{ $$ = 100 - 10;		}
				;

smallHundreds	:	%empty							{ $$ = 0 * 100;			}
				|	'C'								{ $$ = 1 * 100;			}
				|	'C' 'C'							{ $$ = 2 * 100;			}
				|	'C' 'C' 'C'						{ $$ = 3 * 100;			}
				;

hundreds		:	smallHundreds					{ $$ = $1;				}
				|	'C' 'D'							{ $$ = 500 - 100;		}
				|	'D'	smallHundreds				{ $$ = 500 + $2;		}
				|	'C' 'M'							{ $$ = 1000 - 100;		}
				;

halfApostrophus	:	%empty							{ $$ = 0;				}
				|	FIVE_HUNDRED					{ $$ = 500;				}
				|	FIVE_HUNDRED ')'				{ $$ = 500 * 10;		}
				|	FIVE_HUNDRED ')' ')'			{ $$ = 500 * 10 * 10;	}
				;

thousands		:	%empty							{ $$ = 0 * 1000;		}
				|	'M'								{ $$ = 1 * 1000;		}
				|	'M' 'M'							{ $$ = 2 * 1000;		}
				|	'M' 'M' 'M'						{ $$ = 3 * 1000;		}
				;

apostrophus		:	%empty							{ $$ = 0;				}
				|	THOUSAND						{ $$ = 1000;			}
				|	'(' THOUSAND ')'				{ $$ = 1000 * 10;		}
				|	'(' '(' THOUSAND ')' ')'		{ $$ = 1000 * 10 * 10;	}
				;


group			:	apostrophus thousands halfApostrophus hundreds tens units fractions
						{ $$ = $1 + $2 + $3 + $4 + $5 + $6 + $7; }
				;

%%

#include <stdio.h>

void yyerror(double *result, const char *err_msg) {
	(void)(result); /* nop - supress unused parameter warning */
	fprintf(stderr, "%s\n", err_msg);
}

