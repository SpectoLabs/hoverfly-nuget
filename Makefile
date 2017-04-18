build:
	rm -rf tools
	wget https://github.com/SpectoLabs/hoverfly/releases/download/v$(version)/hoverfly_bundle_windows_386.zip -O temp.zip;
	unzip temp.zip -d tools -x *.txt
	mv tools/hoverfly.exe tools/hoverfly
	mv tools/hoverctl.exe tools/hoverctl
	rm -rf temp.zip
	awk \
		-v line=$$(awk '/version/{print NR; exit}' Package.nuspec) \
		-v version=$(version) \
		'{ if (NR == line) print "    <version>${VERSION}</version>"; else print $0}' Package.nuspec > Package.nuspec2
	rm -rf Package.nuspec
	mv Package.nuspec2 Package.nuspec
