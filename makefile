source-directory=`pwd`
src=$(source-directory)/record.sh
target-directory=~/.local/bin
target=$(target-directory)/record.sh

install: clean
	mkdir -p $(target-directory)
	ln -s $(src) $(target)
clean:
	rm -f $(target)

.PHONY: install clean

