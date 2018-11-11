LIBRARIES = -Fu/usr/lib/lazarus/1.8.2/components/lazutils/lib/x86_64-linux

.PHONY: all
all: xpckdgl

xpckdgl: xpckdgl.pas
	fpc $(LIBRARIES) -CX -XX -Xs -o$@ $?

.PHONY: clean
clean:
	$(RM) xpckdgl *.o README.html

.PHONY: install
install:
	install -m 755 -p xpckdgl /usr/bin/xpckdgl

.PHONY: uninstall
uninstall:
	rm -f /usr/bin/xpckdgl

.PHONY: doc
doc: README.html

README.html: README.md
	echo '<!doctype html>\n<html>\n<head>\n<meta charset="utf-8">\n</head>\n<body>' <$< >$@
	pandoc -f markdown_strict -t html <$< >>$@
	echo '</body>\n</html>' <$< >>$@
