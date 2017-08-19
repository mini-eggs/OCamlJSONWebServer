default: build_app run_app
	
build_app:
	clear && corebuild \
	-pkg cohttp,cohttp.async,jwt,yojson \
	src/core_main.native

run_app:
	clear && ./core_main.native

clean:
	rm -rf main.native test.native _build

build_test:
	clear && corebuild -r \
	-pkg cohttp,cohttp.async,jwt,yojson,oUnit \
	src/core_test.native

run_test:
	clear && ./core_test.native

test: build_test run_test

