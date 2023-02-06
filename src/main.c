#include <stdio.h>
#include <stdlib.h>

#include "roman.tab.h"

int main(void) {
	double result;

	if (yyparse(&result) != 0) {
		return EXIT_FAILURE;
	}

	printf("%g\n", result);
	return EXIT_SUCCESS;
}

