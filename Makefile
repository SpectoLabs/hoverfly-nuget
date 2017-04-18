build:
	rm -rf tools
	wget https://github.com/SpectoLabs/hoverfly/releases/download/v$(version)/hoverfly_bundle_windows_386.zip -O temp.zip;
	unzip temp.zip -d tools -x *.txt
	rm -rf temp.zip
	awk \
		-v line=$$(awk '/<version>/{print NR; exit}' Package.nuspec) \
		-v version=$(version) \
		'{ if (NR == line) print "    <version>$(version)</version>"; else print $0}' Package.nuspec > Package.nuspec2
	rm -rf Package.nuspec
	mv Package.nuspec2 Package.nuspec
	docker run -it -v ${PWD}:/data jonathanmorley/nuget pack
