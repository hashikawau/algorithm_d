all:
	gcc -o crypt.exe crypt.c
	echo "hello, world" > foo
	./crypt.exe foo bar 123456
	./crypt.exe bar decrypted 123456
	cat bar
	echo ""
	cat decrypted
	rm crypt.exe foo bar decrypted
