#include <stdarg.h>

extern void putchar(char c);

static void printpad(char c, int n) {
	while (n-- > 0) {
		putchar(c);
	}
}

static void printint(long long xx, int base, int sgn, int cpt, int width, int zero, int left) {
	const char *digits = cpt ? "0123456789ABCDEF" : "0123456789abcdef";
	char buf[64];
	int i, len, neg, pad;
	unsigned long long x;

	neg = 0;
	if (sgn && xx < 0) {
		neg = 1;
		x = 0ULL - (unsigned long long)xx;
	} else {
		x = (unsigned long long)xx;
	}

	i = 0;
	do {
		buf[i++] = digits[x % base];
	} while ((x /= base) != 0);

	len = i + neg;
	pad = width > len ? width - len : 0;

	if (!left && !zero) {
		printpad(' ', pad);
	}
	if (neg) {
		putchar('-');
	}
	if (!left && zero) {
		printpad('0', pad);
	}
	while (--i >= 0) {
		putchar(buf[i]);
	}
	if (left) {
		printpad(' ', pad);
	}
}

static void printstr(const char *s, int width, int left) {
	int len, pad;
	const char *p;

	if (s == 0) {
		s = "(null)";
	}

	len = 0;
	p = s;
	while (*p != 0) {
		len++;
		p++;
	}
	pad = width > len ? width - len : 0;

	if (!left) {
		printpad(' ', pad);
	}
	while (*s != 0) {
		putchar(*s);
		s++;
	}
	if (left) {
		printpad(' ', pad);
	}
}

int printf(const char *restrict fmt, ...) {
	va_list args;
	int i;

	va_start(args, fmt);

	for (i = 0; fmt[i];) {
		int c, left, zero, width, length;

		c = fmt[i] & 0xff;
		if (c != '%') {
			putchar(c);
			i++;
			continue;
		}
		i++;

		left = 0;
		zero = 0;
		for (;;) {
			c = fmt[i] & 0xff;
			if (c == '-') {
				left = 1;
				i++;
			} else if (c == '0') {
				zero = 1;
				i++;
			} else {
				break;
			}
		}

		width = 0;
		while (fmt[i] >= '0' && fmt[i] <= '9') {
			width = width * 10 + (fmt[i] - '0');
			i++;
		}

		length = 0;
		if (fmt[i] == 'l') {
			length = 1;
			i++;
			if (fmt[i] == 'l') {
				length = 2;
				i++;
			}
		}

		c = fmt[i] & 0xff;
		if (c == 0) {
			putchar('%');
			break;
		}
		i++;

		if (c == '%') {
			putchar(c);
		} else if (c == 'c') {
			char ch = (char)va_arg(args, int);
			int pad = width > 1 ? width - 1 : 0;

			if (!left) {
				printpad(' ', pad);
			}
			putchar(ch);
			if (left) {
				printpad(' ', pad);
			}
		} else if (c == 's') {
			printstr(va_arg(args, const char *), width, left);
		} else if (c == 'd' || c == 'i') {
			long long v;

			if (length == 0) {
				v = va_arg(args, int);
			} else if (length == 1) {
				v = va_arg(args, long);
			} else {
				v = va_arg(args, long long);
			}
			printint(v, 10, 1, 0, width, zero, left);
		} else if (c == 'x' || c == 'X') {
			unsigned long long v;
			int upper = c == 'X';

			if (length == 0) {
				v = va_arg(args, unsigned int);
			} else if (length == 1) {
				v = va_arg(args, unsigned long);
			} else {
				v = va_arg(args, unsigned long long);
			}
			printint((long long)v, 16, 0, upper, width, zero, left);
		} else if (c == 'u') {
			unsigned long long v;

			if (length == 0) {
				v = va_arg(args, unsigned int);
			} else if (length == 1) {
				v = va_arg(args, unsigned long);
			} else {
				v = va_arg(args, unsigned long long);
			}
			printint((long long)v, 10, 0, 0, width, zero, left);
		} else if (c == 'p') {
			printint((unsigned int)va_arg(args, void *), 16, 0, 0, width, zero, left);
		} else {
			// Unknown % sequence.  Print it to draw attention.
			putchar('%');
			putchar(c);
		}
	}

	va_end(args);
	return 0;
}
