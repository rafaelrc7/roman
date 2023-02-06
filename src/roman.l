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
[Σ𐆒Є]·					{ return SESCUNCIA;			}
[Σ𐆒Є]					{ return SEMUNCIA;			}
"𐆓𐆓"					{ return BINAE_SEXTULAE;	}
"Ↄ"						{ return SICILICUS;			}
"𐆓"						{ return SEXTULA;			}
"𐆔"						{ return DIMIDIA_SEXTULA;	}
"℈"						{ return SCRIPULUM;			}
"𐆕"						{ return SILIQUA;			}
"(I)"					{ return THOUSAND;			}
"I)"					{ return FIVE_HUNDRED;		}
"·"						{ return '.';				}
[IVXLCDM()|S\.-]		{ return yytext[0];			}
.						{ return YYerror;			}

%%

