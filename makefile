.PHONY : clean sample run inspect help
CC := gcc
CFLAGS := -Iinclude
LDLIBS := -lschrocat
LDFLAGS := -Lbuild

build/libschrocat.a : include/schrocat.h include/schrocat1.h include/schrocat2.h build/schrocat1.o build/schrocat2.o
	@mkdir -p build
	@echo "\e[33mGenerate static library(libschrocat.a) from schrocat1.o and schrocat2.o\e[m"
	ar rcvs $@ build/schrocat1.o build/schrocat2.o
	@echo "\e[36mInput \"make sample\" to use the static library from source.c\e[m"
	@echo ""

build/schrocat1.o : include/schrocat.h include/schrocat1.h src/schrocat1.c
	@mkdir -p build
	@echo "\e[33mGenerate schrocat1.o from schrocat1.c\e[m"
	$(CC) src/schrocat1.c $(CFLAGS) -c -o $@
	@echo ""

build/schrocat2.o : include/schrocat.h include/schrocat2.h src/schrocat2.c
	@mkdir -p build
	@echo "\e[33mGenerate schrocat2.o from schrocat2.c\e[m"
	$(CC) src/schrocat2.c $(CFLAGS) -c -o $@
	@echo ""

sample :
	@mkdir -p build
	@echo "\e[33mExecute a.out\e[m"
	@echo "\e[33m-L option direct path to the static library\e[m"
	@echo "\e[33m-l option is the name of static library(ex. When the file name is libxxx.a, you must write \"-lxxx\")\e[m"
	$(CC) src/source.c $(CFLAGS) $(LDFLAGS) $(LDLIBS) -o ./build/a.out
	@echo "\e[36mInput \"make run\" to execute\e[m"
	@echo ""

run :
	./build/a.out
	@echo ""

inspect : 
	nm build/libschrocat.a
	@echo ""

help :
	@echo "(default) : Generate static library"
	@echo "   sample : Generate sample with library"
	@echo "      run : Execute sample"
	@echo "  inspect : Inspect the generated static library"
	@echo "    clean : Clean built files"
	@echo ""

clean :
	rm -rf build
	@echo ""
