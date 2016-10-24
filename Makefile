
all: index.html

index.html: Makefile src/Main.elm
	elm make --warn src/Main.elm --output index.html
