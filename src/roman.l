%{
	#include "roman.tab.h"

	int yywrap(void) { return 1; }
%}

%option nounput
%option noinput
%option case-insensitive

%%

[[:space:]]+			/* skip */
"nulla"					{ return NULLA;				}
[ฮฃ๐ะ]ยท					{ return SESCUNCIA;			}
[ฮฃ๐ะ]					{ return SEMUNCIA;			}
"๐๐"					{ return BINAE_SEXTULAE;	}
"โ"						{ return SICILICUS;			}
"๐"						{ return SEXTULA;			}
"๐"						{ return DIMIDIA_SEXTULA;	}
"โ"						{ return SCRIPULUM;			}
"๐"						{ return SILIQUA;			}
"(I)"					{ return THOUSAND;			}
"I)"					{ return FIVE_HUNDRED;		}
"ยท"						{ return '.';				}
[IVXLCDM()|S\.-]		{ return yytext[0];			}
.						{ return YYerror;			}

%%

