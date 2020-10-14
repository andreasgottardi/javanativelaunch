all: res javarunner

javarunner: res
	gcc -Wall -pedantic \
		-I"$(JAVAPATH)\include" \
		-I"$(JAVAPATH)\include\win32" \
		-o $(TARGETPATH)/javarunner.exe \
		-municode \
		main.c java.c logging.c resources.res \
		-L"$(JAVAPATH)\lib" \
		-ljvm

res:
	windres resources.rc -O coff -o resources.res